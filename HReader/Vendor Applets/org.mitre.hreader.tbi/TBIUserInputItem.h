//
//  TBIUserInputItem.h
//  HReader
//
//  Created by Saltzman, Shep on 11/15/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBIAudio, TBIImage, TBIStep;

@interface TBIUserInputItem : NSManagedObject

@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) TBIAudio *audio;
@property (nonatomic, retain) TBIImage *image;
@property (nonatomic, retain) TBIStep *step;

- (TBIUserInputItem *) initWithText:(NSString *)textInput;
- (TBIUserInputItem *) initWithText:(NSString *)textInput andSummary:(NSString *)summaryInput;
- (TBIUserInputItem *) initWithAudio:(id)audioInput;
- (TBIUserInputItem *) initWithAudio:(id)audioInput andSummary:(NSString *)summaryInput;
- (TBIUserInputItem *) initWithImage:(UIImage *)imageInput;
- (TBIUserInputItem *) initWithImage:(UIImage *)imageInput andSummary:(NSString *)summaryInput;

- (id) getItem; //fetches the corresponding TBI_____ object: TBIImage, TBIAudio or TBIUserInputItem
- (id) getData; //fetches the underlying data: NSString, id or UIImage
//- (UIView *) getView;

@end
