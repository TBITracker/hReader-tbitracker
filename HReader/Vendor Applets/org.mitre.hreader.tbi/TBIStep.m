//
//  TBIStep.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIStep.h"
#import "TBITask.h"
#import "TBIUserInputItem.h"


@implementation TBIStep

@dynamic duration;
@dynamic task;
@dynamic userinput;


+ (TBIStep *) generateWithContext:(NSManagedObjectContext *)context{
    return (TBIStep *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIStep" inManagedObjectContext:context];
}

+ (TBIStep *) generateWithUserInputItem:(TBIUserInputItem *)userInput andDuration:(NSNumber *)duration andContext:(NSManagedObjectContext *)context{
    return [TBIStep generateWithTask:nil andUserInputItem:userInput andDuration:duration andContext:context];
}

+ (TBIStep *) generateWithTask:(TBITask *)task andUserInputItem:(TBIUserInputItem *)userInput andDuration:(NSNumber *)duration andContext:(NSManagedObjectContext *)context{
    TBIStep *newStep = (TBIStep *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIStep" inManagedObjectContext:context];
    [newStep setValue:userInput forKey:@"userinput"];
    [newStep setValue:duration forKey:@"duration"];
    [newStep setValue:task forKey:@"task"];
    NSError *error = nil;
    [context save:&error];
    return newStep;
}

- (NSString *) description{
    return [NSString stringWithFormat:@"%@, lasting %@ minutes", self.userinput, self.duration];
}

- (id) getData{
    return [self.userinput getData];
}

@end
