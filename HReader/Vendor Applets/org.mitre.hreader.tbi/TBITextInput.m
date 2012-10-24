//
//  TBITextInput.m
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBITextInput.h"

@implementation TBITextInput

@synthesize text;

- (TBITextInput *) initWithText:(NSString *)textInput {
    [super init];
    if (self){
        text = textInput;
    }
    return self;
}

@end
