//
//  TBIAudio.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIAudio.h"
#import "TBIUserInputItem.h"


@implementation TBIAudio

@dynamic audio;
@dynamic userInput;

- (TBIAudio *)initWithAudio:(id)audioInput{
    if (self=[super init]){
        self.audio = audioInput;
    }
    return self;
}


@end
