//
//  tbiTestMemoryViewController.m
//  HReader
//
//  Created by Saltzman, Shep on 8/16/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "tbiTestMemoryViewController.h"

@interface tbiTestMemoryViewController ()

@end

@implementation tbiTestMemoryViewController

@synthesize scrollView;

UITextField *activeField;
UIView *parentView;

- (IBAction) playSound: (id)sender {
    NSLog(@"playSound called");
    
    SystemSoundID soundID = 0;
    //NSString* str = [[NSBundle mainBundle] pathForResource:@"Memory_List1" ofType:@"m4a"];
    NSURL* soundFileURL = [[NSBundle mainBundle] URLForResource:@"list_example" withExtension:@"m4a"];
    NSLog(@"url configured: %@", soundFileURL);
    //CFURLRef soundFileURL = (CFURLRef)[NSURL URLWithString:str];
    //NSLog(@"attempting to play soundfile at URL: %@", CFUrlGetString(soundFileURL));
    //NSLog(@"resolved to URL: %@", soundFileURL);
    OSStatus errorCode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundFileURL , &soundID);
    if(errorCode != 0){
        NSLog(@"soundfile failed to play with errorcode: %ld", errorCode);
    }
    else{
        NSArray *data = [NSArray arrayWithObjects: self, nil];
        [data retain];
        AudioServicesPlaySystemSound(soundID);
        AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundComplete, data);
    }
    
    [self.playButton setEnabled:NO];
    NSLog(@"playSound reached end of function");
}

static void soundComplete(SystemSoundID ssID, void *clientData)
{
    NSArray *clientData_ = (NSArray *)clientData;
    id obj = [clientData_ objectAtIndex:0];
    NSLog(@"soundComplete middle");
    //SEL method = NSSelectorFromString([clientData_ objectAtIndex:1]);

    [obj performSelector: @selector(enableEditing)];
}

- (void) enableEditing {
    NSLog(@"enabledEditing called");
    [[self memory_word_recall_field1] setEnabled:YES];
    [[self memory_word_recall_field2] setEnabled:YES];
    [[self memory_word_recall_field3] setEnabled:YES];
    [[self memory_word_recall_field4] setEnabled:YES];
    [[self memory_word_recall_field5] setEnabled:YES];
    [[self memory_word_recall_field1] setBackgroundColor: [UIColor whiteColor]];
    [[self memory_word_recall_field2] setBackgroundColor: [UIColor whiteColor]];
    [[self memory_word_recall_field3] setBackgroundColor: [UIColor whiteColor]];
    [[self memory_word_recall_field4] setBackgroundColor: [UIColor whiteColor]];
    [[self memory_word_recall_field5] setBackgroundColor: [UIColor whiteColor]];
    
}

- (int)result{
    //NSLog(@"reached MemoryViewController result function");
    NSArray* answers = [[NSArray alloc] initWithObjects:@"apple", @"tiger", @"orange", @"chair", @"boat", nil];
    
    int result = 0;

    if([[[[self memory_word_recall_field1] text] lowercaseString] isEqualToString: [answers objectAtIndex:0]]){
        //NSLog(@"correct!");
        result++;
    }
    if([[[[self memory_word_recall_field2] text] lowercaseString] isEqualToString: [answers objectAtIndex:1]]){
        //NSLog(@"correct!");
        result++;
    }
    if([[[[self memory_word_recall_field3] text] lowercaseString] isEqualToString: [answers objectAtIndex:2]]){
        //NSLog(@"correct!");
        result++;
    }
    if([[[[self memory_word_recall_field4] text] lowercaseString] isEqualToString: [answers objectAtIndex:3]]){
        //NSLog(@"correct!");
        result++;
    }
    if([[[[self memory_word_recall_field5] text] lowercaseString] isEqualToString: [answers objectAtIndex:4]]){
        //NSLog(@"correct!");
        result++;
    }
    return result;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissKeyboard {
    [_memory_word_recall_field1 resignFirstResponder];
    [_memory_word_recall_field2 resignFirstResponder];
    [_memory_word_recall_field3 resignFirstResponder];
    [_memory_word_recall_field4 resignFirstResponder];
    [_memory_word_recall_field5 resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    self.view.frame = CGRectMake(0, 0, 1024, 384);
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];    
    [parentView addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

/*
- (UIView*)getParentView
{
    return parentView;
}
 */

- (void)setParentView:(UIView*)view
{
    parentView = view; //not "self.parentView = view", that's a problem
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)textFieldDoneEditing:(id)sender
{
   
    int nextButton = [sender tag];
    //NSLog(@"textFieldDoneEditing called with nextButton = %i", nextButton);
    if (nextButton > 4){
        [sender resignFirstResponder];
    }
    else {
        [[self.view viewWithTag:nextButton+1] becomeFirstResponder];
    }
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //NSLog(@"field was shown");

    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [activeField.superview setFrame:bkgndRect];
    [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y+25) animated:YES];
     
    //[scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [activeField.superview setFrame:bkgndRect];
    [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-25) animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

@end
