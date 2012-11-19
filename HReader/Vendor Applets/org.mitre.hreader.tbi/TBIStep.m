//
//  TBIStep.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIStep.h"
#import "TBITask.h"
#import "TBIUserInputItem.h"


@implementation TBIStep

@dynamic duration;
@dynamic task;
@dynamic userInput;

-(TBIStep *)initWithText:(NSString *)textInput andDuration:(NSNumber *)durationInput {
    self = [super init];
    if (self){
        self.userInput = [[TBIUserInputItem alloc] initWithText:textInput];
        self.duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithText:(NSString *)textInput andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput {
    self = [super init];
    if (self){
        self.userInput = [[TBIUserInputItem alloc] initWithText:textInput andSummary:summaryInput];
        self.duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithImage:(UIImage *)image andDuration:(NSNumber *)durationInput{
    self = [super init];
    if (self){
        self.userInput = [[TBIUserInputItem alloc] initWithImage:image];
        self.duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithImage:(UIImage *)image andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput{
    self = [super init];
    if (self){
        self.userInput = [[TBIUserInputItem alloc] initWithImage:image andSummary:summaryInput];
        self.duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithAudio:(id)audio andDuration:(NSNumber *)durationInput{
    self = [super init];
    if (self){
        self.userInput = [[TBIUserInputItem alloc] initWithAudio:audio];
        self.duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithAudio:(id)audio andDuration:(NSNumber *)durationInput andSummary:(NSString *)summaryInput{
    self = [super init];
    if (self){
        self.userInput = [[TBIUserInputItem alloc] initWithAudio:audio andSummary:summaryInput];
        self.duration = durationInput;
    }
    return self;
}





- (NSString *) description{
    return [NSString stringWithFormat:@"%@, lasting %@ minutes", self.userInput, self.duration];
}


@end
