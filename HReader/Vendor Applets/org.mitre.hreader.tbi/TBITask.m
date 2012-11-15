//
//  TBITask.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBITask.h"
#import "TBIStep.h"


@implementation TBITask

@dynamic name;
@dynamic steps;
@dynamic successRate;

int currentStep = 0;

- (void) successfulCompletion {
    [self.successRate success];
}

- (void) unsuccessfulCompletion {
    [self.successRate failure];
}

- (TBIStep *) beginTask {
    currentStep = 0;
    if ([self.steps count] > 0) {
        return [self.steps objectAtIndex:0];
    }
    else {
        return nil;
    }
}

- (TBIStep *) currentStep {
    return [self.steps objectAtIndex:currentStep];
}

- (TBIStep *) nextStep {
    currentStep += 1;
    if ((int)[self.steps count] > currentStep) {
        return [self.steps objectAtIndex:currentStep];
    }
    else {
        //maybe this should throw an error instead?
        //or re-return the lastStep?
        return nil;
    }
}

- (BOOL) isOnLastStep {
    return ((int)[self.steps count] == currentStep + 1);
}

-(void) addStep:(TBIStep *)step{
    NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [temp addObject:step];
    self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];
}

/*
 NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
 self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];
 */

-(void) insertStep:(TBIStep *)step AtIndex:(int)i{
    NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [temp insertObject:step atIndex:i];
    self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];

}

-(void) insertBeforeCurrentStep:(TBIStep *)step{
    NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [temp insertObject:step atIndex:currentStep];
    self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];
    currentStep += 1;
}

-(void) insertAfterCurrentStep:(TBIStep *)step{
    NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [temp insertObject:step atIndex:(currentStep+1)];
    self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];

}

-(void) removeStepAtIndex:(int)i{
    NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [temp removeObjectAtIndex:i];
    self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];

}

-(void) replaceStepAtIndex:(int)i withStep:(TBIStep *)step{
    NSMutableOrderedSet *temp = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [temp replaceObjectAtIndex:i withObject:step];
    self.steps = [NSOrderedSet orderedSetWithOrderedSet:temp];

}

- (TBITask *) init {
    if (self=[super init]){
        currentStep = 0;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ (%i steps, %@ success rate", self.name, [self.steps count], self.successRate];
}

@end
