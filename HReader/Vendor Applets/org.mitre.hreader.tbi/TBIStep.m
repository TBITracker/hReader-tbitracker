//
//  TBIStep.m
//  HReader
//
//  Created by Saltzman, Shep on 10/23/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIStep.h"
@implementation TBIStep

@synthesize userInput;
@synthesize duration;

-(TBIStep *)initWithText:(NSString *)textInput andDuration:(NSTimeInterval *)durationInput {
    self = [super init];
    if (self){
        userInput = [[TBITextInput alloc] initWithText:textInput];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithImageURL:(NSURL *)imageURL andDuration:(NSTimeInterval *)durationInput{
    self = [super init];
    if (self){
        userInput = [[TBIImageInput alloc] initWithImageLocation:imageURL];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithAudioURL:(NSURL *)audioURL andDuration:(NSTimeInterval *)durationInput{
    self = [super init];
    if (self){
        userInput = [[TBIAudioInput alloc] initWithAudioLocation:audioURL];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithText:(NSString *)textInput andDuration:(NSTimeInterval *)durationInput andSummary:(NSString *)summaryInput {
    self = [super init];
    if (self){
        userInput = [[TBITextInput alloc] initWithText:textInput andSummary:summaryInput];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithImageURL:(NSURL *)imageURL andDuration:(NSTimeInterval *)durationInput andSummary:(NSString *)summaryInput{
    self = [super init];
    if (self){
        userInput = [[TBIImageInput alloc] initWithImageLocation:imageURL andSummary:summaryInput];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithAudioURL:(NSURL *)audioURL andDuration:(NSTimeInterval *)durationInput andSummary:(NSString *)summaryInput{
    self = [super init];
    if (self){
        userInput = [[TBIAudioInput alloc] initWithAudioLocation:audioURL andSummary:summaryInput];
        duration = durationInput;
    }
    return self;
}

- (NSString *) description{
    return [NSString stringWithFormat:@"%@, lasting %i minutes", userInput, duration];
}

@end
