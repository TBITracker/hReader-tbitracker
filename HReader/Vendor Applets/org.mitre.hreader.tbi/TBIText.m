//
//  TBIText.m
//  HReader
//
//  Created by Saltzman, Shep on 11/21/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIText.h"
#import "TBIUserInputItem.h"


@implementation TBIText

@dynamic text;
@dynamic userinput;


 + (TBIText *) generateWithText:(NSString *)textInput andContext:(NSManagedObjectContext *)context{
     TBIText *newTextObject = (TBIText *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIText" inManagedObjectContext:context];
     [newTextObject setValue:textInput forKey:@"text"];
     
     NSError *error = nil;
     [context save:&error];
     return newTextObject;
 }

- (NSString *) getData {
    return self.text;
}

@end
