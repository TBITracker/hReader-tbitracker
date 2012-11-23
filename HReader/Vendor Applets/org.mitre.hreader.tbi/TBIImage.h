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

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) TBIUserInputItem *userinput;

+ (TBIImage *) generateWithImage:(NSString *)imageInput andContext:(NSManagedObjectContext *)context;
- (UIImage *) getData;

@end
