//
//  TBIAudio.m
//  HReader
//
//  Created by Saltzman, Shep on 11/13/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIAudio.h"
#import "TBIUserInputItem.h"


@implementation TBIAudio

@dynamic audio;
@dynamic userinput;

/*
- (TBIAudio *)initWithAudio:(id)audioInput{
    if (self=[super init]){
        self.audio = audioInput;
    }
    return self;
}
 */

+ (TBIAudio *) generateWithAudio:(NSString *)audioInput andContext:(NSManagedObjectContext *)context{
    TBIAudio *newAudioObject = (TBIAudio *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIAudio" inManagedObjectContext:context];
    [newAudioObject setValue:audioInput forKey:@"audio"];
    
    NSError *error = nil;
    [context save:&error];
    return newAudioObject;
}

- (id) getData{
    return self.audio;
}

@end
