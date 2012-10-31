//
//  TBIAudioInput.m
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIAudioInput.h"

@implementation TBIAudioInput 

@synthesize audioLocation;
//@synthesize transcript;

- (TBIAudioInput *) initWithAudioLocation:(NSURL *)url {
    if (self = [super init]){
        //audioLocation = [NSURL new]; //pretty sure this isn't needed
        audioLocation = url;
    }
    return self;
}

- (TBIAudioInput *) initWithAudioLocation:(NSURL *)url andSummary:(NSString *)summaryInput {
    if (self = [super init]){
        //audioLocation = [NSURL new]; //pretty sure this isn't needed
        audioLocation = url;
        summary = summaryInput; 
    }
    return self;
}


@end
