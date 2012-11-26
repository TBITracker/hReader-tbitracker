//
//  TBIUserInputItem.h
//  HReader
//
//  Created by Saltzman, Shep on 11/15/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBIAudio, TBIImage, TBIText, TBIStep;

@interface TBIUserInputItem : NSManagedObject

@property (nonatomic, retain) NSString *summary;
@property (nonatomic, retain) TBIText *text;
@property (nonatomic, retain) TBIAudio *audio;
@property (nonatomic, retain) TBIImage *image;
@property (nonatomic, retain) TBIStep  *step;

+ (TBIUserInputItem *) generateWithContext:(NSManagedObjectContext *)context;

//Audio Initializers. You may provide either raw audio data or a TBIAudioObject, as well as an optional summary.
+ (TBIUserInputItem *) generateWithAudio:(id)audioInput andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithAudio:(id)audioInput andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithAudioObject:(TBIAudio *)audioObject andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithAudioObject:(TBIAudio *)audioObject andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context;

//Image Initializers. You may provide either the raw UIImage or a TBIImageObject, as well as an optional summary.
+ (TBIUserInputItem *) generateWithImage:(UIImage *)imageInput andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithImage:(UIImage *)imageInput andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithImageObject:(TBIImage *)imageObject andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithImageObject:(TBIImage *)imageObject andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context;

//Text Initializers. You may provide either the raw NSString or a TBITextObject, as well as an optional summary.
+ (TBIUserInputItem *) generateWithText:(NSString *)textInput andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithText:(NSString *)textInput andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithTextObject:(TBIText *)textObject andContext:(NSManagedObjectContext *)context;
+ (TBIUserInputItem *) generateWithTextObject:(TBIText *)textObject andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context;

- (id) getItem; //fetches the corresponding TBI_____ object: TBIAudio, TBIImage or TBIText
- (id) getData; //fetches the underlying data:  id, UIImage or NSString
//- (UIView *) getView;

/*
- (void) setAudio:(id)audio;
- (void) setImage:(UIImage *)image;
- (void) setText:(NSString *)text;
*/

@end
