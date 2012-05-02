//
//  HRSparkLine.m
//  CorePlotExample
//
//  Created by Marshall Huss on 4/30/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "HRSparkLineView.h"
#import "HRSparkLineLine.h"
#import "HRSparkLinePoint.h"


@interface HRSparkLineView ()

- (CGPoint)screenPointWithDataPoint:(HRSparkLinePoint *)point;

@end

@implementation HRSparkLineView {
    CGFloat x_min;
    CGFloat x_max;
    CGFloat y_min;
    CGFloat y_max;
    CGFloat x_delta;
    CGFloat y_delta;
}

@synthesize lines = __lines;
@synthesize visibleRange = __visibleRange;
@synthesize visibleRangeColor = __visibleRangeColor;
@synthesize edgeInsets = __edgeInsets;

#pragma mark - class methods

//+ (id)appearance {
//    static dispatch_once_t token;
//    static HRSparkLineView *view = nil;
//    dispatch_once(&token, ^{
//        view = [[HRSparkLineView alloc] init];
//        view.visibleRangeColor = [UIColor colorWithWhite:0.9 alpha:1.0];
//        view.backgroundColor = [UIColor whiteColor];
//    });
//    return view;
//}
//
//+ (id)appearanceWhenContainedIn:(Class <UIAppearanceContainer>)ContainerClass, ... {
    //    static dispatch_once_t token;
    //    static HRSparkLineLine *line = nil;
    //    dispatch_once(&token, ^{
    //        line = [[HRSparkLineLine alloc] init];
    //    });
    //    return line;
//    return nil;
//}

#pragma mark - instance methods

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.visibleRangeColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = YES;
    __visibleRange = HRZeroRange;
    __edgeInsets = UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0);
}

- (void)setLines:(NSArray *)lines {
    __lines = [lines copy];
    [self setNeedsDisplay];
}

- (void)setVisibleRange:(HRSparkLineRange)visibleRange {
    __visibleRange = visibleRange;
    [self setNeedsDisplay];
}

- (void)setVisibleRangeColor:(UIColor *)color {
    __visibleRangeColor = color;
    [self setNeedsDisplay];
}

- (void)setEdgeInsets:(UIEdgeInsets)insets {
    __edgeInsets = insets;
    [self setNeedsDisplay];
}

- (CGPoint)screenPointWithDataPoint:(HRSparkLinePoint *)point {
    return [self screenPointWithX:point.x y:point.y];
}

- (CGPoint)screenPointWithX:(CGFloat)x y:(CGFloat)y {
    CGFloat x_percent = (x - x_min) / (x_max - x_min);
    CGFloat y_percent = 1 - (y - y_min) / (y_max - y_min);
    CGSize size = self.bounds.size;
    UIEdgeInsets insets = self.edgeInsets;
    size.width = size.width - insets.left - insets.right;
    size.height = size.height - insets.top - insets.bottom;
    return CGPointMake(floorf(x_percent * size.width + insets.left), floorf(y_percent * size.height + insets.top));
}

- (void)drawRect:(CGRect)rect {
    [self determineVisibleRange];
    
    // get drawing resources
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw visible range
    CGPoint leftRangePoint = [self screenPointWithX:0 y:HRMaxRange(self.visibleRange)];
    CGPoint rightRangePoint = [self screenPointWithX:0 y:self.visibleRange.location];
    CGContextSetFillColorWithColor(context, self.visibleRangeColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, leftRangePoint.y, self.bounds.size.width, rightRangePoint.y - leftRangePoint.y));
    
    // draw all lines
    [self.lines enumerateObjectsUsingBlock:^(HRSparkLineLine *line, NSUInteger lineIndex, BOOL *stop) {
        
        // create paths for this line
        CGMutablePathRef inRangeDotPath = CGPathCreateMutable();
        CGMutablePathRef outOfRangeDotPath = CGPathCreateMutable();
        NSUInteger pointCount = [line.points count];
        
        // add points to the current path
        [line.points enumerateObjectsUsingBlock:^(HRSparkLinePoint *point, NSUInteger pointIndex, BOOL *stop) {
            
            // calculate screen points
            CGPoint screenPoint = [self screenPointWithDataPoint:point];
            static CGFloat const HRSparkLineViewDotScale = 1.5;
            CGFloat dotScale = HRSparkLineViewDotScale;
            if (pointIndex == pointCount - 1) { dotScale = 2.2; }
            
            CGRect dotRect = CGRectMake(floorf(screenPoint.x - line.weight * dotScale * 0.5),
                                        floorf(screenPoint.y - line.weight * dotScale * 0.5),
                                        ceilf(line.weight * dotScale),
                                        ceilf(line.weight * dotScale));
            
            // draw out of bound points
            if (!HRIsZeroRange(line.range) && !HRLocationInRange(point.y, line.range)) {
                CGPathAddEllipseInRect(outOfRangeDotPath, NULL, dotRect);
            }
            else if (pointIndex == pointCount - 1 || pointCount < 4) {
                CGPathAddEllipseInRect(inRangeDotPath, NULL, dotRect);
            }
            
            // draw the line
            if (pointIndex == 0) { CGContextMoveToPoint(context, screenPoint.x, screenPoint.y); }
            else { CGContextAddLineToPoint(context, screenPoint.x, screenPoint.y); }
            
        }];
        
        // draw line
        CGContextSetLineWidth(context, line.weight);
        CGContextSetStrokeColorWithColor(context, [line.lineColor CGColor]);
        CGContextSetFillColorWithColor(context, [line.lineColor CGColor]);
        CGContextSetLineJoin(context, line.lineJoin);
        CGContextSetLineCap(context, line.lineCap);
        CGContextStrokePath(context);
        
        // get ready to draw points
        CGContextSetLineWidth(context, MAX(1.0, floorf(line.weight / 2.0)));
        CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
        
        // draw in range points
        CGContextSetStrokeColorWithColor(context, [line.lineColor CGColor]);
        CGContextAddPath(context, inRangeDotPath);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        // draw out of range points
        CGContextSetStrokeColorWithColor(context, [line.outOfRangeDotColor CGColor]);
        CGContextAddPath(context, outOfRangeDotPath);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        // release
        CFRelease(inRangeDotPath);
        CFRelease(outOfRangeDotPath);
        
    }];
    
}

- (void)determineVisibleRange {
    
    // set min and max
    x_min = y_min = CGFLOAT_MAX;
    x_max = y_max = CGFLOAT_MIN;
    
    // check all lines
    [__lines enumerateObjectsUsingBlock:^(HRSparkLineLine *line, NSUInteger idx, BOOL *stop) {
        [line.points enumerateObjectsUsingBlock:^(HRSparkLinePoint *point, NSUInteger idx, BOOL *stop) {
            x_min = MIN(x_min, point.x);
            x_max = MAX(x_max, point.x);
            y_min = MIN(y_min, point.y);
            y_max = MAX(y_max, point.y);
        }];     
    }];
    
    // grab deltas
    x_delta = ABS(x_max - x_min);
    y_delta = ABS(y_max - y_min);     
    
    // adjust for visible range
    if (!HRIsZeroRange(self.visibleRange)) {
        y_min = MIN(y_min, self.visibleRange.location);
        y_max = MAX(y_max, HRMaxRange(self.visibleRange));
    }
    
}

@end
