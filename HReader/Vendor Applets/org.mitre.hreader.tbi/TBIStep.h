//
//  TBIStep.h
//  HReader
//
//  Created by Saltzman, Shep on 10/23/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBIUserInput.h"
#import "TBITextInput.h"
#import "TBIImageInput.h"
#import "TBIAudioInput.h"

@interface TBIStep : NSObject {
    TBIUserInput *userInput;
    NSTimeInterval *duration;
}

@property (nonatomic, retain) TBIUserInput *userInput;
@property (nonatomic) NSTimeInterval *duration;

-(TBIStep *)initWithText:(NSString*)textInput andDuration:(NSTimeInterval*)durationInput;

-(TBIStep *)initWithImageURL:(NSURL*)imageURL andDuration:(NSTimeInterval*)durationInput;

-(TBIStep *)initWithAudioURL:(NSURL*)audioURL andDuration:(NSTimeInterval*)durationInput;

@end
