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
//@dynamic name;

- (TBIImage *) initWithImage:(UIImage *)imageInput {
    if (self=[super init]){
        NSLog(@"1");
        [self setImage:imageInput];
        NSLog(@"2");
    }
    return self;
}

-(UIImage *) getData{
    return self.image;
}

@end
