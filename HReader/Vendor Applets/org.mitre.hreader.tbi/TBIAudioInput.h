//
//  TBIAudioInput.h
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInput.h"

@interface TBIAudioInput : TBIUserInput {
    NSURL *audioLocation;
    //NSString *transcript;
}

@property (nonatomic, retain) NSURL *audioLocation;
//@property (nonatomic, retain) NSString *transcript;

- (TBIAudioInput *) initWithAudioLocation:(NSURL *) url;
- (TBIAudioInput *) initWithAudioLocation:(NSURL *) url andSummary:(NSString *)summaryInput;

@end
