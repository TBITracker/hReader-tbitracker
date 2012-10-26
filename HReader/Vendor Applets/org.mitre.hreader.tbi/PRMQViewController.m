//
//  PRMQViewController.m
//  HReader
//
//  Created by Saltzman, Shep on 8/21/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "PRMQViewController.h"

@interface PRMQViewController ()

@end

@implementation PRMQViewController

@synthesize labelText;

//Note to self: this is a class variable. It needs to be an instance variable. 
//int selected = 1;

-(IBAction) detectedClick{
    NSLog(@"click detected");
}

-(IBAction) segmentedControlIndexChanged{
    /*
    NSLog(@"I noticed a change! Now index is: %i", self.segmentedControl.selectedSegmentIndex);
    [self.segmentedControl setEnabled:YES forSegmentAtIndex:4];
    NSLog(@"segment 3 enabled?: %d", [self.segmentedControl isEnabledForSegmentAtIndex:3]);
    NSLog(@"segment 4 enabled?: %d", [self.segmentedControl isEnabledForSegmentAtIndex:4]);
    */
    //selected = self.segmentedControl.selectedSegmentIndex + 1;
}

/*
- (void) prepareText:(NSString*)text {
    NSLog(@"prepareText called with text: %@", text);
    labelText = [[NSString alloc] initWithString:text];
    NSLog(@"labelText set to: %@", labelText);
}
*/
- (int)result {
    //NSLog(@"PRMQ result called, returning: %i", self.segmentedControl.selectedSegmentIndex+1);
    //NSLog(@"But I could also return return %i instead", selected);
    return self.segmentedControl.selectedSegmentIndex + 1;
    //return selected;
}

//[tbiTestStoryboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"prmq%i", i]]

/* //I want to make my own initialization method that takes an additional argument, but I'm not sure how,
 //since the VCs are being created by a method belonging to the storyboard.
- (id) instantiateViewControllerWithIdentifier:(NSString *)identifier andQuestionText:(NSString *)questionText
{
    id return_id = 
}
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //NSLog(@"initWithNibName called");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad called");
    //[self.segmentedControl setEnabled:YES forSegmentAtIndex:4];
    [super viewDidLoad];
    NSLog(@"Attempting to set %@ to %@", self.questionText, labelText);
    [self.questionText setText:labelText];
	// Do any additional setup after loading the view.
    //NSLog(@"my parentVC is: %@", [self parentViewController]); //doesn't work, use delegate instead
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}



@end
