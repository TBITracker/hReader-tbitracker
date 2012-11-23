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
    
    //Add a new userInputItem -- it is automatically added to the end thanks to Step's generation method
    userInputItem = [TBIUserInputItem generateWithText:[DataTester getRandomString] andSummary:@"summary goes here" andContext:context];
    step = [TBIStep generateWithTask:task andUserInputItem:userInputItem andDuration:[NSNumber numberWithInt:13] andContext:context];
    NSLog(@"New step added. Task list is now: %@", [task steps]);
    
    //Add a new userInputItem and make it the first one in the list
    userInputItem = [TBIUserInputItem generateWithText:[DataTester getRandomString] andSummary:@"summary goes here" andContext:context];
    step = [TBIStep generateWithUserInputItem:userInputItem andDuration:[NSNumber numberWithInt:13] andContext:context];
    [task insertStep:step AtIndex:0];
    NSLog(@"New step added. Task list is now: %@", [task steps]);
    
    //From a task, fetch all of its Steps, or all of their raw data
    NSLog(@"Testing FetchAllSteps: %@", [task fetchAllSteps]);
    NSLog(@"Testing FetchAllData: %@", [task fetchAllData]);
    
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

+(void) initialize {
    NSLog(@"initializing tester. Context = %@", context);
    if (!context) {
        context = [[TBIDataManager sharedInstance] managedObjectContext];
    }
    NSLog(@"initialiation complete. Context = %@", context);
}




@end
