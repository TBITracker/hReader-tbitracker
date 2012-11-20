//
//  TBITask.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBITask.h"
#import "TBIStep.h"
#import "TBIUserInputItem.h"
#import "TBIDataManager.h"

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

+ (NSManagedObjectContext *)newContext{
    return [[TBIDataManager sharedInstance] managedObjectContext];
}

+ (NSMutableArray *) fetchAllTasksWithContext:(NSManagedObjectContext*)context{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"TBITask" inManagedObjectContext:context]];
    
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"Failed to load Tasks. Error description: %@", [error localizedDescription]);
    } else {
        NSLog(@"Fetched %d tasks!", [mutableFetchResults count]);
    }
    return mutableFetchResults;
}

- (NSOrderedSet*)fetchAllSteps{
    return self.steps;
}

- (NSOrderedSet*)fetchAllUserInputItems{
    return [self.steps valueForKey:@"userInput"];
}

- (NSOrderedSet*)fetchAllInputs{
    //makeObjectsPerformSelector only works with a method that returns (void)
    //NSOrderedSet* inputs = [[self.steps valueForKey:@"userInput"] makeObjectsPerformSelector:@selector(getItem)];
    NSOrderedSet* inputItems = [self fetchAllUserInputItems];
    
    NSMutableOrderedSet *inputs = [NSMutableOrderedSet alloc];
    for (TBIUserInputItem *item in inputItems) {
        [inputs addObject:[item getItem]];
    }
    
    return inputs;
}

- (NSOrderedSet*)fetchAllData{
    NSOrderedSet* inputItems = [self fetchAllUserInputItems];
    
    NSMutableOrderedSet *dataSet = [NSMutableOrderedSet alloc];
    for (TBIUserInputItem *item in inputItems) {
        [dataSet addObject:[item getData]];
    }
    
    return dataSet;
}

@end
