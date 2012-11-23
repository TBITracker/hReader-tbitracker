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

@class TBIPercentageTracker, TBIStep;

@interface TBITask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *steps;
@property (nonatomic, retain) TBIPercentageTracker *successRate;
@end

@interface TBITask (CoreDataGeneratedAccessors)

+ (TBITask *) generateWithName:(NSString *)name andContext:(NSManagedObjectContext *)context;

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


+ (NSManagedObjectContext*)newContext;
+ (NSMutableArray *) fetchAllTasksWithContext:(NSManagedObjectContext*)context;

//fetch all the data associated with a Task
- (NSMutableArray *)fetchAllSteps; //equivalent to [task steps]
- (NSOrderedSet*)fetchAllUserInputItems; //transforms each step into its associated TBIUserInputItem
- (NSOrderedSet*)fetchAllInputs; //transforms each TBIUserInputItem into its associated TBIAudio/TBIImage/TBIText
- (NSOrderedSet*)fetchAllData; //transform each TBIAudio/TBIImage/TBIText into its associated id/UIImage/NSString (probably not useful)

/*
 - (void)insertObject:(TBIStep *)value inStepsAtIndex:(NSUInteger)idx;
 - (void)removeObjectFromStepsAtIndex:(NSUInteger)idx;
 - (void)insertSteps:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
 - (void)removeStepsAtIndexes:(NSIndexSet *)indexes;
 - (void)replaceObjectInStepsAtIndex:(NSUInteger)idx withObject:(TBIStep *)value;
 - (void)replaceStepsAtIndexes:(NSIndexSet *)indexes withSteps:(NSArray *)values;
 - (void)addStepsObject:(TBIStep *)value;
 - (void)removeStepsObject:(TBIStep *)value;
 - (void)addSteps:(NSOrderedSet *)values;
 - (void)removeSteps:(NSOrderedSet *)values;
 */
@end
