//
//  TBIImage.h
//  HReader
//
//  Created by Saltzman, Shep on 11/1/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TBIImage : NSManagedObject

@property (nonatomic, retain) UIImage* image;

@end
