//
//  TBIImageInput.m
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIImageInput.h"

@implementation TBIImageInput

@synthesize imageLocation;

- (TBIImageInput *) initWithImageLocation:(NSURL *)url {
    if (self = [super init]){
        //imageLocation = [NSURL new]; //pretty sure this isn't needed
        imageLocation = url;
    }
    return self;
}

- (TBIImageInput *) initWithImageLocation:(NSURL *)url andSummary:(NSString *)summaryInput {
    if (self = [super init]){
        //imageLocation = [NSURL new]; //pretty sure this isn't needed
        imageLocation = url;
        summary = summaryInput;
    }
    return self;
}

@end
