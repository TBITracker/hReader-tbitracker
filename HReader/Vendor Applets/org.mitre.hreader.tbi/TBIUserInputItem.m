//
//  TBIUserInputItem.m
//  HReader
//
//  Created by Saltzman, Shep on 11/1/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInputItem.h"


@implementation TBIUserInputItem

@dynamic text;
@dynamic image;
@dynamic audio;
@dynamic summary;

- (void) setNil{
    self.text = nil;
    self.image = nil;
    self.audio = nil;
    self.summary = nil;
}

- (TBIUserInputItem *) initWithText:(NSString *)textInput {
    return [self initWithText:textInput andSummary:@""];
}

- (TBIUserInputItem *) initWithText:(NSString *)textInput andSummary:(NSString *)summaryInput {
    if (self = [super init]){
        [self setNil];
        self.text = textInput;
        self.summary = summaryInput;
    }
    return self;
}

- (TBIUserInputItem *) initWithImage:(id)imageInput {
    return [self initWithImage:imageInput andSummary:@""];
}

- (TBIUserInputItem *) initWithImage:(id)imageInput andSummary:(NSString *)summaryInput{
    if (self = [super init]){
        [self setNil];
        self.image = imageInput;
        self.summary = summaryInput;
    }
    return self;
}

- (TBIUserInputItem *) initWithAudio:(id)audioInput {
    return [self initWithAudio:audioInput andSummary:@""];
}

- (TBIUserInputItem *) initWithAudio:(id)audioInput andSummary:(NSString *)summaryInput{
    if (self = [super init]){
        [self setNil];
        self.image = audioInput;
        self.summary = summaryInput;
    }
    return self;
}


-(NSString *)description {
    //NSString *blurb = [text substringToIndex:30];
    return [NSString stringWithFormat:@"TBIUserInputItem"];
}

@end
