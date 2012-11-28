//
//  DataTester.m
//  HReader
//
//  Created by Saltzman, Shep on 11/21/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "DataTester.h"

#import "TBIDataManager.h"
#import "TBITask.h"
#import "TBIStep.h"
#import "TBIText.h"
#import "TBIImage.h"
#import "TBIUserInputItem.h"

static NSManagedObjectContext *context;

@implementation DataTester

+ (BOOL) generateRandomTextObject{
    NSString *randomString = [DataTester getRandomString];
    NSLog(@"generating Random Text object: %@", randomString);
    NSManagedObject *newTextObject = [NSEntityDescription insertNewObjectForEntityForName:@"TBIUserInputItem" inManagedObjectContext:context];
    [newTextObject setValue:randomString forKey:@"text"];
    return YES;
}

+ (void) makeNewTextObject{
    NSString *randomString = [DataTester getRandomString];
    NSLog(@"generating Random Text object: %@", randomString);
    [TBIText generateWithText:randomString andContext:context];
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"error while saving");
    }
    else {
        NSLog(@"Saved!");
    }
}

+ (NSMutableArray *) fetchAllTBITextObjects{
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:[NSEntityDescription entityForName:@"TBIText" inManagedObjectContext:context]];
    
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"Error while fetching");
    }
    else {
        NSLog(@"Fetched %d items!", [mutableFetchResults count]);
        NSLog(@"%@ and %@ are the first and last objects", [[mutableFetchResults objectAtIndex:0] getData], [[mutableFetchResults lastObject] getData]);
    }
    return mutableFetchResults;
}

+ (void) generateDataWithContext:(NSManagedObjectContext *)context{
    //Create a task
    TBITask *task = [TBITask generateWithName:[DataTester getRandomString] andContext:context];
    
    //Create a series of Steps, each with its own UserInputItem, and add them to the Task (via Step's generation method)
    TBIUserInputItem *userInputItem;
    TBIStep *step;
    for (int i =0; i<3; i++){
        userInputItem = [TBIUserInputItem generateWithText:[DataTester getRandomString] andSummary:@"summary goes here" andContext:context];
        step = [TBIStep generateWithTask:task andUserInputItem:userInputItem andDuration:[DataTester getRandomNumber] andContext:context];
    }
    
    //Confirm that the Task exists and its Steps are attached. Walk down to the data.
    NSLog(@"Task is: %@", task);
    NSLog(@"Steps are: %@ (%d steps)", [task steps], [[task steps] count]);
    step = [[task steps] objectAtIndex:0];
    NSLog(@"First step is: %@", step);
    NSLog(@"Data: %@", [step getData]);
    
    //Confirm that the connection between the Step and the Task is bi-directional
    NSLog(@"Step's task is: %@", [step task]);
    
    //Add a new userInputItem and make it the first one in the list
    userInputItem = [TBIUserInputItem generateWithText:[DataTester getRandomString] andSummary:@"summary goes here" andContext:context];
    step = [TBIStep generateWithUserInputItem:userInputItem andDuration:[NSNumber numberWithInt:13] andContext:context];
    NSManagedObjectID *stepID = [step objectID];
    [task insertStep:step AtIndex:0];
    NSLog(@"New step added. Task list is now: %@", [task steps]);
    
    //alter the property of an item by walking down to it and then calling the appropriate set____: method
    [ (TBIText *)[[[[task steps] objectAtIndex:0] userinput] getItem] setText:@"First Item"];
    NSLog(@"getting data from first element: %@", [[[[task steps] objectAtIndex:1] userinput] getData]);
    
    //fetch an object directly from the database given its ID
    NSManagedObject *fetchedStep = [context existingObjectWithID:stepID error:nil];
    NSLog(@"fetched object: %@", fetchedStep);
    
    //From a task, fetch all of its Steps, or all of their raw data
    NSLog(@"Testing FetchAllSteps: %@", [task fetchAllSteps]);
    NSLog(@"Testing FetchAllData: %@", [task fetchAllData]);
    
     [context save:nil];
     
}

+ (NSString*) getRandomString
{
    char data[30];
    for (int x=0;x<30;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:30 encoding:NSUTF8StringEncoding];
}

+ (NSNumber *) getRandomNumber {
    int i = arc4random_uniform(10)+1;
    return [NSNumber numberWithInt:i];
}

+ (void) saveImageWithContext:(NSManagedObjectContext *)context {
    UIImage *myImage = [UIImage imageNamed:@"scene1"];
    TBIImage *myTBIImage = [TBIImage generateWithImage:myImage andContext:context];
    UIImage *myImage2 = [UIImage imageNamed:@"scene2"];
    TBIImage *myTBIImage2 = [TBIImage generateWithImage:myImage2 andContext:context];
    NSLog(@"Adding TBIImages: %@ and %@", myTBIImage, myTBIImage2);
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"TBIImage" inManagedObjectContext:context]];
    
    NSError *error = nil;
    
    NSMutableArray *allImages = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (allImages == nil)
    {
        NSLog(@"Could not get images");
    } else {
        NSLog(@"Images fetched: %d", [allImages count]);
    }

    
}

+(void) initialize {
    NSLog(@"initializing tester. Context = %@", context);
    if (!context) {
        context = [[TBIDataManager sharedInstance] managedObjectContext];
    }
    NSLog(@"initialiation complete. Context = %@", context);
}




@end
