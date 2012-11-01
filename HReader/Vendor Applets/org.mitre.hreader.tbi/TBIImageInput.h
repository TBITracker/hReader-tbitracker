//
//  TBIImageInput.h
//  HReader
//
//  Created by Saltzman, Shep on 10/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInput.h"

@interface TBIImageInput : TBIUserInput {
    NSURL *imageLocation;
}

@property (nonatomic, retain) NSURL *imageLocation;

- (TBIImageInput *) initWithImageLocation:(NSURL *)url;
- (TBIImageInput *) initWithImageLocation:(NSURL *)url andSummary:(NSString *)summary;

@end
