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
    NSError *err;
    NSString *imgName = [self getRandomFileName];
    NSURL *photosDir = [[HRAppletUtilities URLForAppletContainer:@"org.mitre.tbi-tracker"] URLByAppendingPathComponent:@"photos"];
    NSURL *savePath = [photosDir URLByAppendingPathComponent:imgName];

    //NSLog(@"Save path: %@", savePath);

    //Check if photos directory exists
    NSFileManager *fm = [[NSFileManager alloc]init];
    if ([photosDir checkResourceIsReachableAndReturnError:&err] == NO)
         {
            [fm createDirectoryAtURL:photosDir withIntermediateDirectories:YES attributes:nil error:&err];
         }
    
    BOOL itworked = [UIImageJPEGRepresentation(image, 1.0)writeToURL:savePath atomically:YES];
    if (!itworked)
        NSLog(@"Didn't save the file...");
}


+ (NSString*) getRandomFileName
{
    char data[30];
    for (int x=0;x<30;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[[NSString alloc] initWithBytes:data length:30 encoding:NSUTF8StringEncoding] stringByAppendingString:@".jpg"];
}


+ (NSArray*) getAllImages
{
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[HRAppletUtilities URLForAppletContainer:@"org.mitre.tbi-tracker"] URLByAppendingPathComponent:@"photos"];
    return [fileMgr contentsOfDirectoryAtURL:documentsDirectory includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
}

@end
