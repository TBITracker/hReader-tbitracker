//
//  NSArray+Collect.h
//  HReader
//
//  Created by Marshall Huss on 2/29/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Collect)

- (NSArray *)collect:(id (^) (id object, NSUInteger idx))block;

@end