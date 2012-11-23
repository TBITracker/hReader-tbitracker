//
//  TBIAudio.h
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBIUserInputItem;

@interface TBIAudio : NSManagedObject

@property (nonatomic, retain) id audio;
@property (nonatomic, retain) TBIUserInputItem *userinput;

+ (TBIAudio *) generateWithAudio:(NSString *)audioInput andContext:(NSManagedObjectContext *)context;
- (id) getData;

@end
