//
//  DataTester.h
//  HReader
//
//  Created by Saltzman, Shep on 11/21/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataTester : NSObject

+ (BOOL) generateRandomTextObject;
+ (void) makeNewTextObject;
+ (NSMutableArray *) fetchAllTBITextObjects;

+ (void) generateDataWithContext:(NSManagedObjectContext *)context;

+ (void) saveImageWithContext:(NSManagedObjectContext *)context;

@end
