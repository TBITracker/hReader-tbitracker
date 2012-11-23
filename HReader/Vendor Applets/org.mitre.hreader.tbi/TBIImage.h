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
@property (nonatomic, retain) TBIUserInputItem *userinput;

//- (TBIImage *) initWithImage:(UIImage *)imageInput andContext:(NSManagedObjectContext*)context;

+ (TBIImage *) generateWithImage:(NSString *)imageInput andContext:(NSManagedObjectContext *)context;
- (UIImage *) getData;
//- (void)setImage:(UIImage *)imageInput;

@end
