//
//  TBITask.h
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TBIPercentageTracker.h"

@class TBIStep;

@interface TBITask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *steps;
@property (nonatomic, retain) TBIPercentageTracker *successRate;
@end

@interface TBITask (CoreDataGeneratedAccessors)

- (void)addStepsObject:(TBIStep *)value;
- (void)removeStepsObject:(TBIStep *)value;
- (void)addSteps:(NSSet *)values;
- (void)removeSteps:(NSSet *)values;

- (void)   successfulCompletion;
- (void) unsuccessfulCompletion;

- (TBIStep *) beginTask;
- (TBIStep *) currentStep;
- (TBIStep *) nextStep;
- (BOOL) isOnLastStep;

-(void) addStep:(TBIStep *)step;
-(void) insertStep:(TBIStep *)step AtIndex:(int)i;
-(void) insertBeforeCurrentStep:(TBIStep *)step;
-(void) insertAfterCurrentStep:(TBIStep *)step;
-(void) removeStepAtIndex:(int)i;
-(void) replaceStepAtIndex:(int)i withStep:(TBIStep *)step;

@end
