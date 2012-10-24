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
    [super init];
    if (self){
        //imageLocation = [NSURL new]; //pretty sure this isn't needed
        imageLocation = url;
    }
    return self;
}

@end
