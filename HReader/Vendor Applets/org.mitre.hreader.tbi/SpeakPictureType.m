//
//  SpeakPictureType.m
//  HReader
//
//  Created by Kaye, Lindsay M on 9/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "SpeakPictureType.h"
#import "CameraUtil.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface SpeakPictureType()

@end


@implementation SpeakPictureType

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupVerticalScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupVerticalScrollView
{
    scrollView.delegate = self;
    
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    [scrollView setCanCancelContentTouches:NO];
    
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.clipsToBounds = NO;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    NSUInteger nimages = 0;
    NSInteger tot = 0; //For now 15, need to see what we want
    CGFloat cx = 0;
    
    NSArray *allImages = [CameraUtil getAllImages];
    
    for (NSString *imgName in allImages)
    {
        //NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", (nimages + 1)];
        NSLog(@"Image name: %@s", imgName);
        UIImage *image = [UIImage imageNamed:imgName];
        if (tot==15)
        {
            break;
        }
        if (8 == nimages)
        {
            nimages = 0;
        }
        UIImageView *thumbsView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = thumbsView.frame;
        rect.size.height = 40;
        rect.size.width = 40;
        rect.origin.x = 0;
        rect.origin.y = cx;
        
        thumbsView.frame = rect;
        
        [scrollView addSubview:thumbsView];
        
        cx += thumbsView.frame.size.width + 5;
        tot++;
    }
    //self.pageControl.numberOfPages = nimages;
    [scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}

-(IBAction)presentCamera:(id)sender
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*)controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {
    //Test if camera is available
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        NSLog(@"%@", delegate);
        NSLog(@"%@",controller);
        NSLog(@"%i", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]);
        NSLog(@"NO");
        
        //Use this image I made up
        NSArray* possibleURLs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);
        NSString* appSupportDir = nil;
        NSString* appDirectory = nil;
        
        if ([possibleURLs count] >= 1) {
            // Use the first directory (if multiple are returned)
            appSupportDir = [possibleURLs objectAtIndex:0];
        }
        
        // If a valid app support directory exists, add the
        // app's bundle ID to it to specify the final directory.
        if (appSupportDir) {
            NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
            appDirectory = [appSupportDir stringByAppendingPathComponent:appBundleID];
        }
        NSString *filename = [appDirectory stringByAppendingPathComponent:@"cat.jpg"];

        UIImage *catPic = [[UIImage alloc] initWithContentsOfFile:filename];
        
        [CameraUtil saveImage:catPic];
        
    } else {
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //We only want to use a camera not movies
    cameraUI.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
    
    //No editing allowed.  Because I said so.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentModalViewController: cameraUI animated:YES];
    NSLog(@"YES");
    }
    
    return YES;
}

/*-(IBAction)useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc ] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
        //newMedia = YES;
    }
}

-(IBAction)useCamerRoll:(id)sender
{
    
}*/


@end
