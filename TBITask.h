//
//  TBITask.h
//  HReader
//
//  Created by Saltzman, Shep on 11/8/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBIStep;

@interface TBITask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *steps;
@end

@interface TBITask (CoreDataGeneratedAccessors)

- (void)addStepsObject:(TBIStep *)value;
- (void)removeStepsObject:(TBIStep *)value;
- (void)addSteps:(NSSet *)values;
- (void)removeSteps:(NSSet *)values;

@end
