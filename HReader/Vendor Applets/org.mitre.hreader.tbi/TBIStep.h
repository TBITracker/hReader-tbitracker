//
//  TBIStep.h
//  HReader
//
//  Created by Saltzman, Shep on 10/23/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBIUserInput.h"

@interface TBIStep : NSObject {
    TBIUserInput *userInput;
    NSTimeInterval *duration;
}

@property (nonatomic, retain) TBIUserInput *userInput;
@property (nonatomic) NSTimeInterval *duration;

@end
