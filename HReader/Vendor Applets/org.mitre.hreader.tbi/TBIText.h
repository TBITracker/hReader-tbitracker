//
//  TBIText.h
//  HReader
//
//  Created by Saltzman, Shep on 11/21/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBIUserInputItem;

@interface TBIText : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) TBIUserInputItem *userinput;

@end
