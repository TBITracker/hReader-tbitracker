//
//  TBITrackerDashboard.m
//  HReader
//
//  Created by Lindsay Kaye on 5/15/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBITrackerDashboard.h"

@implementation TBITrackerDashboard

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TESTING NSEntityDescription for TBIImage
    NSLog(@"attempting to create context");
    NSManagedObjectContext *ctx = [[TBIDataManager sharedInstance] managedObjectContext];
    NSLog(@"attempting to fetch TBIImage EntityDescription");
    NSEntityDescription *testNED = [NSEntityDescription entityForName:@"TBIImage" inManagedObjectContext:ctx];
    NSLog(@"attempt did not crash");
    if (testNED != nil) {
        NSLog(@"Got entity description: %@", [testNED description]);
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction) taskTap:(id)sender {
    UIStoryboard *tbiTask = [UIStoryboard storyboardWithName:@"TBIPages" bundle:nil];
    //UIStoryboard *tbiTask = [UIStoryboard storyboardWithName:@"taskStoryboard" bundle:nil];
    UIViewController *controller = [tbiTask instantiateInitialViewController];
    controller.title = @"Tasks";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction) mocaButtonTap: (id) sender {
    //Note sender is the button
    
    UIStoryboard *tbiTest = [UIStoryboard storyboardWithName:@"tbiTest" bundle:nil];
    //UIStoryboard *tbiTest = [UIStoryboard storyboardWithName:@"taskStoryboard" bundle:nil];
    
    UIViewController *controller = [tbiTest instantiateInitialViewController];
    controller.title = @"Self-Assessment";
    [self.navigationController pushViewController:controller animated:YES];
    //[self.parentViewController.navigationController pushViewController:controller animated:YES];
}


@end
