//
//  PercentageTracker.m
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "PercentageTracker.h"

@implementation PercentageTracker 

- (void)success{
    numerator += 1;
    denominator += 1;
}

- (void)failure{
    denominator += 1;
}

- (void)reset{
    numerator = 0;
    denominator = 0;
}

- (NSString *)result{
    return [self description];
}

- (NSString *)description{
    if (denominator == 0){
        return @"--%";
    }
    else {
        return [NSString stringWithFormat:@"%f%%", round((numerator/denominator)*100)];
    }
}

- (PercentageTracker*) init {
    [super init];
    if (self){
        [self reset];
    }
    return self;
}




@end
