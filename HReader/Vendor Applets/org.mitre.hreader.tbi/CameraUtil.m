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
    NSString *imgName = [self getRandomFileName];
    NSLog(@"Name: %@", imgName);
    NSURL *savePath = [[[HRAppletUtilities URLForAppletContainer:@"org.mitre.tbi-tracker"] URLByAppendingPathComponent:@"photos"] URLByAppendingPathComponent:imgName];
    
    [UIImagePNGRepresentation(image)writeToURL:savePath atomically:YES];
    
}


+ (NSString*) getRandomFileName
{
    char data[30];
    for (int x=0;x<30;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:30 encoding:NSUTF8StringEncoding];
}


+ (NSArray*) getAllImages
{
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[HRAppletUtilities URLForAppletContainer:@"org.mitre.tbi-tracker"] URLByAppendingPathComponent:@"photos"];
    return [fileMgr contentsOfDirectoryAtURL:documentsDirectory includingPropertiesForKeys:nil options:0 error:&error];
}

@end
