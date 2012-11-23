//
//  TBIUserInputItem.m
//  HReader
//
//  Created by Saltzman, Shep on 11/15/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "TBIUserInputItem.h"
#import "TBIAudio.h"
#import "TBIImage.h"
#import "TBIStep.h"
#import "TBIText.h"


@implementation TBIUserInputItem

@dynamic summary;
@dynamic text;
@dynamic audio;
@dynamic image;
@dynamic step;

- (void) reset {
    self.text = nil;
    self.audio = nil;
    self.image = nil;
}


+ (TBIUserInputItem *) generateWithContext:(NSManagedObjectContext *)context{
    TBIUserInputItem *newInputObject = (TBIUserInputItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIUserInputItem" inManagedObjectContext:context];
    NSError *error = nil;
    [context save:&error];
    return newInputObject;
}



+ (TBIUserInputItem *) generateWithAudio:(id)audioInput andContext:(NSManagedObjectContext *)context{
    return [TBIUserInputItem generateWithAudio:audioInput andSummary:@"" andContext:context];
    
}
+ (TBIUserInputItem *) generateWithAudio:(id)audioInput andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context {
    TBIAudio *newAudioObject = (TBIAudio *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIAudio" inManagedObjectContext:context];
    [newAudioObject setValue:audioInput forKey:@"audio"];
    return [TBIUserInputItem generateWithAudioObject:newAudioObject andSummary:summary andContext:context];
}

+ (TBIUserInputItem *) generateWithAudioObject:(TBIAudio *)audioObject andContext:(NSManagedObjectContext *)context{
    return [TBIUserInputItem generateWithAudioObject:audioObject andSummary:@"" andContext:context];
}

+ (TBIUserInputItem *) generateWithAudioObject:(TBIAudio *)audioObject andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context {
    TBIUserInputItem *newInputObject = (TBIUserInputItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIUserInputItem" inManagedObjectContext:context];
    [newInputObject setValue:audioObject forKey:@"audio"];
    NSError *error = nil;
    [context save:&error];
    return newInputObject;
}

+ (TBIUserInputItem *) generateWithImage:(id)imageInput andContext:(NSManagedObjectContext *)context{
    return [TBIUserInputItem generateWithImage:imageInput andSummary:@"" andContext:context];
    
}
+ (TBIUserInputItem *) generateWithImage:(id)imageInput andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context {
    TBIImage *newImageObject = (TBIImage *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIImage" inManagedObjectContext:context];
    [newImageObject setValue:imageInput forKey:@"image"];
    return [TBIUserInputItem generateWithImageObject:newImageObject andSummary:summary andContext:context];
}

+ (TBIUserInputItem *) generateWithImageObject:(TBIImage *)imageObject andContext:(NSManagedObjectContext *)context{
    return [TBIUserInputItem generateWithImageObject:imageObject andSummary:@"" andContext:context];
}

+ (TBIUserInputItem *) generateWithImageObject:(TBIImage *)imageObject andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context {
    TBIUserInputItem *newInputObject = (TBIUserInputItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIUserInputItem" inManagedObjectContext:context];
    [newInputObject setValue:imageObject forKey:@"image"];
    NSError *error = nil;
    [context save:&error];
    return newInputObject;
}

+ (TBIUserInputItem *) generateWithText:(NSString *)textInput andContext:(NSManagedObjectContext *)context{
    return [TBIUserInputItem generateWithText:textInput andSummary:@"" andContext:context];
    
}
+ (TBIUserInputItem *) generateWithText:(NSString *)textInput andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context {
    TBIText *newTextObject = (TBIText *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIText" inManagedObjectContext:context];
    [newTextObject setValue:textInput forKey:@"text"];
    return [TBIUserInputItem generateWithTextObject:newTextObject andSummary:summary andContext:context];
}

+ (TBIUserInputItem *) generateWithTextObject:(TBIText *)textObject andContext:(NSManagedObjectContext *)context{
    return [TBIUserInputItem generateWithTextObject:textObject andSummary:@"" andContext:context];
}

+ (TBIUserInputItem *) generateWithTextObject:(TBIText *)textObject andSummary:(NSString*)summary andContext:(NSManagedObjectContext *)context {
    TBIUserInputItem *newInputObject = (TBIUserInputItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TBIUserInputItem" inManagedObjectContext:context];
    [newInputObject setValue:textObject forKey:@"text"];
    NSError *error = nil;
    [context save:&error];
    return newInputObject;
}

- (id) getItem {
    if (self.text != nil){
        return self.text; 
    }
    else if (self.audio != nil){
        return self.audio;
    }
    else if (self.image != nil){
        return self.image;
    }
    return nil;
}

- (id) getData {
    if (self.text != nil){
        return [self.text text];
    }
    else if (self.audio != nil){
        return [self.audio audio];
    }
    else if (self.image != nil){
        return [self.image image];
    }
    return nil;
}

- (void) setAudio:(TBIAudio *)audio{
    [self reset];
    self.audio = audio;
}

- (void) setImage:(TBIImage *)image{
    [self reset];
    self.image = image;
}

- (void) setText:(TBIText *)text{
    [self reset];
    self.text = text;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@", [self getData]];
}

@end
