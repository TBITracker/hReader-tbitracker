//
//  TBIUIImageView.h
//  HReader
//
//  Created by Kaye, Lindsay M on 10/22/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TBIUIImageView : UIImageView

@property (strong, retain) NSManagedObjectID *imageName;

@end
