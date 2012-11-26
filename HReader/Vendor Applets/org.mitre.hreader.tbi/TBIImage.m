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
@dynamic userinput;

+ (TBIImage *) generateWithImage:(UIImage *)imageInput andContext:(NSManagedObjectContext *)context{
    TBIImage *newImageObject = (TBIImage *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIImage" inManagedObjectContext:context];
    [newImageObject setValue:imageInput forKey:@"image"];

    NSError *error = nil;
    [context save:&error];
    return newImageObject;
}

-(UIImage *) getData{
    return self.image;
}

@end
