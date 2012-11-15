//
//  TBIPercentageTracker.h
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBITask;

@interface TBIPercentageTracker : NSManagedObject

@property (nonatomic, retain) NSNumber * denominator;
@property (nonatomic, retain) NSNumber * numerator;
@property (nonatomic, retain) TBITask *task;

- (void)success;
- (void)failure;
- (void)reset;
- (NSString *)result;

@end
