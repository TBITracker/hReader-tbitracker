//
//  TBIPercentageTracker.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIPercentageTracker.h"
#import "TBITask.h"


@implementation TBIPercentageTracker

@dynamic denominator;
@dynamic numerator;
@dynamic task;

- (void)success{
    self.numerator = [NSNumber numberWithInt:[self.numerator intValue] + 1];
    self.denominator = [NSNumber numberWithInt:[self.denominator intValue] + 1];
}

- (void)failure{
    self.denominator = [NSNumber numberWithInt:[self.denominator intValue] + 1];;
}

- (void)reset{
    self.numerator = [NSNumber numberWithInt:0];
    self.denominator = [NSNumber numberWithInt:0];
}

- (NSString *)result{
    return [self description];
}

- (NSString *)description{
    if ([self.denominator intValue] == 0){
        return @"--%";
    }
    else {
        return [NSString stringWithFormat:@"%f%%", round(([self.numerator floatValue]/[self.denominator floatValue])*100)];
    }
}

- (TBIPercentageTracker*) init {
    if (self=[super init]){
        [self reset];
    }
    return self;
}

@end
