//
//  TBIImage.h
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBIUserInputItem;

@interface TBIImage : NSManagedObject

//@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) TBIUserInputItem *userInput;

- (TBIImage *) initWithImage:(UIImage *)imageInput andContext:(NSManagedObjectContext*)context;

//- (void) setImage:(UIImage *)image;

- (UIImage *) getData;
//- (void)setImage:(UIImage *)imageInput;

@end
