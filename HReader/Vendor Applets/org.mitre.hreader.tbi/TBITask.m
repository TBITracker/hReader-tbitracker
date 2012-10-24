//
//  TBITask.m
//  HReader
//
//  Created by Saltzman, Shep on 10/23/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBITask.h"

@implementation TBITask

@synthesize name;
@synthesize duration;
@synthesize steps;
@synthesize completionPercent;

- (void) successfulCompletion {
    [completionPercent success];
}

- (void) unsuccessfulCompletion {
    [completionPercent failure];
}

- (TBIStep *) beginTask {
    currentStep = 0;
    if ([steps count] > 0) {
        return [steps objectAtIndex:0];
    }
    else {
        return nil;
    }
}

- (TBIStep *) nextStep {
    currentStep += 1;
    if ((int)[steps count] > currentStep) {
        return [steps objectAtIndex:currentStep];
    }
    else {
        return nil;
    }
}

- (TBITask *) init {
    [super init];
    if (self){
        currentStep = 0;
    }
    return self;
}

@end
