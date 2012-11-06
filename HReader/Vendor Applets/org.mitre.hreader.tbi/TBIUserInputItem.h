//
//  TBIUserInputItem.h
//  HReader
//
//  Created by Saltzman, Shep on 11/1/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TBIUserInputItem : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) id audio;
@property (nonatomic, retain) NSString * summary;

- (void) setNil;

- (TBIUserInputItem *) initWithText:(NSString*)textInput;
- (TBIUserInputItem *) initWithText:(NSString*)textInput andSummary:(NSString *)summaryInput;

- (TBIUserInputItem *) initWithImage:(id)imageInput;
- (TBIUserInputItem *) initWithImage:(id)imageInput andSummary:(NSString *)summaryInput;

- (TBIUserInputItem *) initWithAudio:(id)audioInput;
- (TBIUserInputItem *) initWithAudio:(id)audioInput andSummary:(NSString *)summaryInput;

@end
