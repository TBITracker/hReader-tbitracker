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
//@dynamic name;

/*
- (TBIImage *) initWithImage:(UIImage *)imageInput andContext:(NSManagedObjectContext *)context{
    TBIImage *item = (TBIImage*)[NSEntityDescription insertNewObjectForEntityForName:@"TBIImage" inManagedObjectContext:context];
    item.image = imageInput;
    
    return item;
}
*/

+ (TBIImage *) generateWithImage:(NSString *)imageInput andContext:(NSManagedObjectContext *)context{
    TBIImage *newImageObject = (TBIImage *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIImage" inManagedObjectContext:context];
    [newImageObject setValue:imageInput forKey:@"text"];

    NSError *error = nil;
    [context save:&error];
    return newImageObject;
}

-(UIImage *) getData{
    return self.image;
}

@end
