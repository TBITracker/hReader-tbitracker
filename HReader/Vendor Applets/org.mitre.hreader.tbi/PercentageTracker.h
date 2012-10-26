//
//  PercentageTracker.h
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PercentageTracker : NSObject {
    float numerator;
    float denominator;
}

- (void)success;
- (void)failure;
- (void)reset;
- (NSString *)result;
@end
