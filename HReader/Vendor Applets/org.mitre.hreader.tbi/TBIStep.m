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
        //userInput = (TBIUserInput *)[[TBIUserInput alloc] initWithText:textInput];
        userInput = [[TBITextInput alloc] initWithText:textInput];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithImageURL:(NSURL *)imageURL andDuration:(NSTimeInterval *)durationInput{
    self = [super init];
    if (self){
        //userInput = (TBIUserInput *)[[TBIUserInput alloc] initWithImageURL:imageURL];
        userInput = [[TBIImageInput alloc] initWithImageLocation:imageURL];
        duration = durationInput;
    }
    return self;
}

-(TBIStep *)initWithAudioURL:(NSURL *)audioURL andDuration:(NSTimeInterval *)durationInput{
    self = [super init];
    if (self){
        //userInput = (TBIUserInput *)[[TBIUserInput alloc] initWithAudioURL:audioURL];
        userInput = [[TBIAudioInput alloc] initWithAudioLocation:audioURL];
        duration = durationInput;
    }
    return self;
}

@end
