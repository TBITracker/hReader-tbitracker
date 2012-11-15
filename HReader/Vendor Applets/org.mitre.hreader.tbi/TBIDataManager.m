//
//  TBIDataManager.m
//  HReader
//
//  Created by Mauer, Dan on 10/29/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIDataManager.h"

NSString * const TBIDataManagerDidSaveNotification = @"TBIDataManagerDidSaveNotification";
NSString * const TBIDataManagerDidSaveFailedNotification = @"TBIDataManagerDidSaveFailedNotification";

@interface TBIDataManager ()

@end

@implementation TBIDataManager

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainObjectContext = _mainObjectContext;
@synthesize objectModel = _objectModel;

NSString * const kTBIDataManagerBundleName = nil; // use main bundle
NSString * const kTBIDataManagerModelName = @"TBIDataModel";
NSString * const kTBIDataManagerSQLiteName = @"TBIDatabase";

+ (TBIDataManager*)sharedInstance {
    static dispatch_once_t pred;
    static TBIDataManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (void)dealloc {
    [self save];
}

- (NSManagedObjectModel*)objectModel {
    if (_objectModel)
        return _objectModel;
    
    NSBundle *bundle = [NSBundle mainBundle];
    if (kTBIDataManagerBundleName) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:kTBIDataManagerBundleName ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    NSString *modelPath = [bundle pathForResource:kTBIDataManagerModelName ofType:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    
    return _objectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    if (_persistentStoreCoordinator)
        return _persistentStoreCoordinator;
    
    // Get the paths to the SQLite file
    NSURL *storeURL = [[HRAppletUtilities URLForAppletContainer:@"org.mitre.tbi-tracker"] URLByAppendingPathComponent:kTBIDataManagerSQLiteName];
    
    // Define the Core Data version migration options
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
    // Attempt to load the persistent store
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
    if (!HRCryptoManagerAddEncryptedStoreToCoordinator(_persistentStoreCoordinator,
                                                       nil,
                                                       storeURL,
                                                       options,
                                                       &error)) {
        NSLog(@"Fatal error while creating persistent store: %@", error);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext*)mainObjectContext {
    if (_mainObjectContext)
        return _mainObjectContext;
    
    // Create the main context only on the main thread
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(mainObjectContext)
                               withObject:nil
                            waitUntilDone:YES];
        return _mainObjectContext;
    }
    
    _mainObjectContext = [[NSManagedObjectContext alloc] init];
    [_mainObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return _mainObjectContext;
}

- (BOOL)save {
    if (![self.mainObjectContext hasChanges])
        return YES;
    
    NSError *error = nil;
    if (![self.mainObjectContext save:&error]) {
        NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
        [[NSNotificationCenter defaultCenter] postNotificationName:TBIDataManagerDidSaveFailedNotification
                                                            object:error];
        return NO;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TBIDataManagerDidSaveNotification object:nil];
    return YES;
}

- (NSManagedObjectContext*)managedObjectContext {
    NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] init];
    [ctx setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return ctx;
}

@end
