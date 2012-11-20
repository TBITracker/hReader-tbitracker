//
//  TBIUserInputItem.m
//  HReader
//
//  Created by Saltzman, Shep on 11/15/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInputItem.h"
#import "TBIAudio.h"
#import "TBIImage.h"
#import "TBIStep.h"


@implementation TBIUserInputItem

@dynamic summary;
@dynamic text;
@dynamic audio;
@dynamic image;
@dynamic step;

- (void) reset {
    self.text = nil;
    self.audio = nil;
    self.image = nil;
}

- (TBIUserInputItem *) initWithText:(NSString *)textInput {
    return [self initWithText:textInput andSummary:@"No summary"];
}

- (TBIUserInputItem *) initWithText:(NSString *)textInput andSummary:(NSString *)summaryInput{
    if (self = [super init]){
        [self reset];
        self.text = textInput;
    }
    return self;
}

- (TBIUserInputItem *) initWithAudio:(id)audioInput {
    return [self initWithAudio:audioInput andSummary:@"No summary"];
}

- (TBIUserInputItem *) initWithAudio:(id)audioInput andSummary:(NSString *)summaryInput {
    if (self = [super init]){
        [self reset];
        self.audio = [[TBIAudio alloc] initWithAudio:audioInput];
    }
    return self;
}

- (TBIUserInputItem *) initWithImage:(UIImage *)imageInput {
    return [self initWithImage:imageInput andSummary:@"No summary"];
}

- (TBIUserInputItem *) initWithImage:(UIImage *)imageInput andSummary:(NSString *)summaryInput {
    if (self = [super init]){
        [self reset];
        self.image = [[TBIImage alloc] initWithImage:imageInput];
    }
    return self;
}

- (id) getItem {
    if (self.text != nil){
        return self; //self IS the Item that holds the data...
    }
    else if (self.audio != nil){
        return self.audio;
    }
    else if (self.image != nil){
        return self.image;
    }
    return nil;
}

- (id) getData {
    if (self.text != nil){
        return self.text;
    }
    else if (self.audio != nil){
        return [self.audio audio];
    }
    else if (self.image != nil){
        return [self.image image];
    }
    return nil;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ (%@)", [self getItem], self.summary];
}

@end
