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

- (TBIImage *) initWithImage:(UIImage *)imageInput andContext:(NSManagedObjectContext *)context{
    TBIImage *item = (TBIImage*)[NSEntityDescription insertNewObjectForEntityForName:@"TBIImage" inManagedObjectContext:context];
    item.image = imageInput;
    
    return item;

}

-(UIImage *) getData{
    return self.image;
}

@end
