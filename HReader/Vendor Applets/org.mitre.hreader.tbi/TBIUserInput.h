//
//  TBIUserInput.h
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TBITextInput.h"
//#import "TBIImageInput.h"
//#import "TBIAudioInput.h"
@class TBITextInput;
@class TBIImageInput;
@class TBIAudioInput;

@interface TBIUserInput : NSObject {
    NSString *summary;
}

@property (nonatomic, retain) NSString *summary;

//-(NSUserInput *)initWithType:(int)type withData:(id)data;

-(TBIUserInput *)init;
-(TBIUserInput *)initWithSummary:(NSString *)summaryInput;

//-(TBITextInput *)initWithText:(NSString*)textInput;
//-(TBIImageInput *)initWithImageURL:(NSURL*)audioURL;
//-(TBIAudioInput *)initWithAudioURL:(NSURL*)imageURL;
 
@end
