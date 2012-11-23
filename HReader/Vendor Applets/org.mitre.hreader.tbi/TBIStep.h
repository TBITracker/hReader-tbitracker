//
//  TBIStep.h
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBITask, TBIUserInputItem;

@interface TBIStep : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) TBITask *task;
@property (nonatomic, retain) TBIUserInputItem *userinput;



+ (TBIStep *) generateWithContext:(NSManagedObjectContext *)context;

//Use this method only if you need to add the new Step somewhere other than the end of the Task's list. 
+ (TBIStep *) generateWithUserInputItem:(TBIUserInputItem *)userInput andDuration:(NSNumber*)duration andContext:(NSManagedObjectContext *)context;

//This will add the Step to the end of the Task. If you need to add it somewhere else, generate the UserInputItem using the above method and then add it in the correct place through the Task.
+ (TBIStep *) generateWithTask:(TBITask *)task andUserInputItem:(TBIUserInputItem *)userInput andDuration:(NSNumber*)duration andContext:(NSManagedObjectContext *)context;

- (id) getData;

/*
 -(TBIStep *)initWithText:(NSString*)textInput andDuration:(NSNumber *)durationInput;
 -(TBIStep *)initWithText:(NSString*)textInput andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput;
 
 -(TBIStep *)initWithImage:(UIImage*)image andDuration:(NSNumber *)durationInput;
 -(TBIStep *)initWithImage:(UIImage*)image andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput;
 
 -(TBIStep *)initWithAudio:(id)audio andDuration:(NSNumber *)durationInput;
 -(TBIStep *)initWithAudio:(id)audio andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput;
 */

@end
