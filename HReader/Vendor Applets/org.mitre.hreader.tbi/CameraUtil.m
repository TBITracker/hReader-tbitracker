//
//  CameraUtil.m
//  HReader
//
//  Created by Kaye, Lindsay M on 9/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "CameraUtil.h"
#import "HRAppletUtilities.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "TBIDataManager.h"



@implementation CameraUtil

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

+ (void) saveImage:(UIImage *)image
{
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
	[self performSelectorOnMainThread:@selector(alertUserThatImageSaved) withObject:nil waitUntilDone:NO];
}



-(void) alertUserThatImageSaved
{
    //dosomething
}

+ (NSString*) getRandomFileName
{
    char data[30];
    for (int x=0;x<30;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[[NSString alloc] initWithBytes:data length:30 encoding:NSUTF8StringEncoding] stringByAppendingString:@".jpg"];
}


+ (NSArray*) getAllImages
{
    /*NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[HRAppletUtilities URLForAppletContainer:@"org.mitre.tbi-tracker"] URLByAppendingPathComponent:@"photos"];
    return [fileMgr contentsOfDirectoryAtURL:documentsDirectory includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];*/
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [[TBIDataManager sharedInstance] managedObjectContext];
    NSLog(@"entity: %@", [NSEntityDescription entityForName:@"TBIImage" inManagedObjectContext:context]);
    [request setEntity:[NSEntityDescription entityForName:@"TBIImage" inManagedObjectContext:context]];
    
    NSError *error = nil;
    
    NSMutableArray *allImages = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (allImages == nil)
    {
        NSLog(@"Could not get images");
    } else {
        NSLog(@"Images fetched: %d", [allImages count]);
    }
    return allImages;
}

@end
