//
//  TBITask.h
//  HReader
//
//  Created by Saltzman, Shep on 10/23/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBIStep.h"
#import "PercentageTracker.h"

@interface TBITask : NSObject {
    NSString *name;
    NSTimeInterval *duration;
    NSMutableArray *steps;
    PercentageTracker *completionPercent;
    
    @private
    int currentStep;
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSTimeInterval *duration;
@property (nonatomic, retain) NSMutableArray *steps;
@property (nonatomic, retain) PercentageTracker *completionPercent;

- (void)   successfulCompletion;
- (void) unsuccessfulCompletion;

- (TBIStep *) beginTask;
- (TBIStep *) nextStep;


@end
