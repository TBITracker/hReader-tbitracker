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
@property (nonatomic, retain) NSString * audio;
@property (nonatomic, retain) UNKNOWN_TYPE summary;

@end
