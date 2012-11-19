//
//  SpeakPictureType.m
//  HReader
//
//  Created by Kaye, Lindsay M on 9/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "SpeakPictureType.h"
#import "CameraUtil.h"
#import "AlertPrompt.h"
#import "TBIUIImageView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "TBIDataManager.h"

@interface SpeakPictureType()


@end


@implementation SpeakPictureType

@synthesize scrollView, thumbsVisible;

CGRect originalScrollView;
NSMutableArray *currentlyLoadedLoadedImages;
float contentXOffsetAtLastUpdate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        NSManagedObject *imgName = [self.allImages objectAtIndex:indexPath.row];

        /*NSData *imgdata = [NSData dataWithContentsOfURL:imgName];
        UIImage *image = [[UIImage alloc] initWithData:imgdata];
        /*TBIUIImageView *thumbsView = [[TBIUIImageView alloc] initWithImage:image];
        
        thumbsView.imageName = imgName;*/
    
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCell" forIndexPath:indexPath];
        
        //[cell addSubview:thumbsView];
    /*UIImageView *imgincell = (UIImageView*)[cell viewWithTag:100];
    imgincell.image = image;*/
    
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell setImage:[UIImage imageWithData:[object valueForKey:@"cvCell"]]];
    
    return cell;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"All images count %d", [self.allImages count]);
    return [self.allImages count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (IBAction)presentTextBox:(id)sender
{
    AlertPrompt *txtBox = [[AlertPrompt alloc] initWithTitle:@"Step" message:@"Type in step informaton" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Add Step"];
    [txtBox show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.allImages = [CameraUtil getAllImages];
    if (self.allImages == nil)
    {
        NSLog(@"Could not retrieve images, may not have any");
    }
    NSLog(@"Number of images: %d", self.allImages.count);
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(225, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.thumbsVisible = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateContentsofImageScrollView
{
    
}

- (IBAction)showHideView:(id)sender
{
    NSLog(@"Beginning animation");
    if (self.thumbsVisible)
    {
        [UIView beginAnimations:@"animatePhotosdown" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
       self.collectionView.frame = CGRectOffset(self.collectionView.frame, 0, self.collectionView.frame.size.height);
        [UIView commitAnimations];
        self.thumbsVisible = NO;
    } else {
        [UIView beginAnimations:@"animatePhotosup" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        self.collectionView.frame = CGRectOffset(self.collectionView.frame, 0, -self.collectionView.frame.size.height);
        [UIView commitAnimations];
        self.thumbsVisible = YES;
    }
}


//When picture is tapped bring it up
- (IBAction)handleSingleSingleTap:(UIGestureRecognizer *)sender {
    NSLog(@"I got touched!");
    //Set up a large imageview over everything else
    /*CGRect popOver = CGRectMake(0.0, 0.0, 768, 1024);
    UIView *background = [[UIView alloc] init];
    background.frame = popOver;
    [background setBackgroundColor:[UIColor blackColor]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:background];
    //And give it a done button
    navBar = [[UINavigationBar alloc] init];
    navItem = [[UINavigationItem alloc] initWithTitle:@"Photo"];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView:)];
    navItem.rightBarButtonItem = doneButton;
    navBar.items = [NSArray arrayWithObject:navItem];
    [background addSubview:navBar];
    
    //Now add uiimageview in the center
    NSData *imgdata = [NSData dataWithContentsOfURL:((TBIUIImageView*)sender.view).imageName];
    UIImage *image = [[UIImage alloc] initWithData:imgdata];
    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationLeft];
    TBIUIImageView *imageToShow = [[TBIUIImageView alloc] initWithImage:image];
    [imageToShow setCenter:CGPointMake(CGRectGetMidX([background bounds]), CGRectGetMidY([background bounds]))];
    [background addSubview:imageToShow];*/
}

-(IBAction)dismissView:(id)sender
{
    NSLog(@"Done clicked!");
}

-(IBAction)recordAndSave:(id)sender
{
    
}

-(IBAction)launchRecord:(id)sender
{
    
    UIStoryboard *tbiTask = [UIStoryboard storyboardWithName:@"TBIPages" bundle:nil];
    //UIStoryboard *tbiTask = [UIStoryboard storyboardWithName:@"taskStoryboard" bundle:nil];
    UIViewController *controller = [tbiTask instantiateViewControllerWithIdentifier:@"RecordAudio"];
    controller.title = @"Record Audio";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationController.navigationItem.rightBarButtonItem = doneButton;
    [self.navigationController pushViewController:controller animated:YES];
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
        NSArray* possibleURLs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
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
        //NSLog(@"Filename: %@", filename);

        UIImage *catPic = [[UIImage alloc] initWithContentsOfFile:filename];
        
        [CameraUtil saveImage:catPic];
        
    } else {
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    //cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    
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

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    //Now save it
    NSManagedObjectContext *context = [[TBIDataManager sharedInstance] managedObjectContext];
    NSManagedObject *imageSave = [NSEntityDescription insertNewObjectForEntityForName:@"TBIImage" inManagedObjectContext:context];
    [imageSave setValue:image forKey:@"image"];
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Could not save the image");
    } else {
        NSLog(@"Successfully saved image");
    }
    [self dismissModalViewControllerAnimated:YES];
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
