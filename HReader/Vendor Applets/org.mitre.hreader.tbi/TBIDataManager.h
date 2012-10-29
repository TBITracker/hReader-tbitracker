//
//  TBITBIDataManager.h
//  HReader
//
//  Created by Mauer, Dan on 10/29/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "HRAppletUtilities.h"
#import "HRCryptoManager.h"

extern NSString * const TBIDataManagerDidSaveNotification;
extern NSString * const TBIDataManagerDidSaveFailedNotification;

@interface TBIDataManager : NSObject {
}

@property (nonatomic, readonly, retain) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, retain) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, readonly, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (TBIDataManager*)sharedInstance;
- (BOOL)save;
- (NSManagedObjectContext*)managedObjectContext;

@end
