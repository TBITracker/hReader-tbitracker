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
@property (nonatomic, retain) TBIUserInputItem *userInput;

-(TBIStep *)initWithText:(NSString*)textInput andDuration:(NSNumber *)durationInput;
-(TBIStep *)initWithText:(NSString*)textInput andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput;


-(TBIStep *)initWithImage:(UIImage*)image andDuration:(NSNumber *)durationInput;
-(TBIStep *)initWithImage:(UIImage*)image andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput;

-(TBIStep *)initWithAudio:(id)audio andDuration:(NSNumber *)durationInput;
-(TBIStep *)initWithAudio:(id)audio andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput;


@end
