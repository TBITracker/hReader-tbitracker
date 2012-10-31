//
//  UITBITaskSlider.m
//  HReader
//
//  Created by Saltzman, Shep on 10/11/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "UITBITaskSlider.h"

@implementation UITBITaskSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self appearance];
        
    }
    return self;
}

- (void) appearance
{
    //NSLog(@"imageTest: %@ and %@", [UIImage imageNamed:@"slider"], [UIImage imageNamed:@"slider-1px"]);
    [self setMinimumValueImage:[UIImage imageNamed:@"sliderEnd"]];
    [self setMinimumTrackImage:[UIImage imageNamed:@"sliderBarGreen"] forState:0];
    [self setThumbImage:[UIImage imageNamed:@"slider"] forState:0];
    [self setMaximumTrackImage:[UIImage imageNamed:@"sliderBar"] forState:0];
    [self setMaximumValueImage:[UIImage imageNamed:@"sliderEnd"]];
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    CGSize thumbSize = [self thumbImageForState:0].size;
    //NSLog(@"bounds: at (%f, %f) with size (%f, %f)",bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    //NSLog(@"rect:   at (%f, %f) with size (%f, %f)",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGRect returnRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    //NSLog(@"returns: at (%f, %f) with size (%f, %f)",returnRect.origin.x, returnRect.origin.y, returnRect.size.width, returnRect.size.height);
    return [super thumbRectForBounds:bounds trackRect:rect value:value];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
