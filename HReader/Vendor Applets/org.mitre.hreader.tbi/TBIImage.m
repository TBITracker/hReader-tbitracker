//
//  TBIImage.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIImage.h"
#import "TBIUserInputItem.h"


@implementation TBIImage

@dynamic image;
@dynamic userInput;

- (TBIImage *) initWithImage:(UIImage *)imageInput {
    if (self=[super init]){
        self.image = imageInput;
    }
    return self;
}

-(UIImage *) getData{
    return self.image;
}

@end
