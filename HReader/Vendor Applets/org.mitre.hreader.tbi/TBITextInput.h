//
//  TBITextInput.h
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInput.h"

//@class TBIUserInput;

@interface TBITextInput : TBIUserInput {
    NSString *text;
    //NSString *transcript;
}

@property (nonatomic, retain) NSString *text;

- (TBITextInput *) initWithText:(NSString*)textInput;
- (TBITextInput *) initWithText:(NSString*)textInput andSummary:(NSString *)summaryInput;
@end
