//
//  TBIUserInput.m
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInput.h"

#import "TBITextInput.h"
#import "TBIImageInput.h"
#import "TBIAudioInput.h"

@implementation TBIUserInput

@synthesize summary;

-(TBIUserInput *)init{
    return [self initWithSummary:@""];
}

-(TBIUserInput *)initWithSummary:(NSString *)summaryInput{
    if(self = [super init]){
        summary = summaryInput;
    }
    return self;
}


/*
-(TBITextInput *)initWithText:(NSString*)textInput{
    self = [super init];
    if(self){
        TBITextInput *obj = [[TBITextInput alloc] initWithText:textInput];
        summary = @"";
        return obj;
    }
    else{
        return nil;
    }
}

-(TBIAudioInput *)initWithAudioURL:(NSURL*)audioURL{
    self = [super init];
    if(self){
        TBIAudioInput *obj = [[TBIAudioInput alloc]initWithAudioLocation:audioURL];
        summary = @"";
        return obj;
    }
    else{
        return nil;
    }
}

-(TBIImageInput *)initWithImageURL:(NSURL*)imageURL{
    self = [super init];
    if(self){
        TBIImageInput *obj = [[TBIImageInput alloc]initWithImageLocation:imageURL];
        summary = @"";
        return obj;
    }
    else{
        return nil;
    }
}
*/

@end
