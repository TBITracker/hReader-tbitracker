//
//  HRMPatient.m
//  HReader
//
//  Created by Caleb Davenport on 2/7/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import "HRMPatient.h"
#import "HRMEntry.h"
#import "HRAppDelegate.h"

#import "DDXML.h"

static HRMPatient *selectedPatient = nil;

@implementation HRMPatient

@dynamic dateOfBirth;
@dynamic firstName;
@dynamic lastName;
@dynamic race;
@dynamic ethnicity;
@dynamic gender;
@dynamic compositeName;
@dynamic genderString;
@dynamic dateOfBirthString;
@dynamic entries;

@dynamic encounters;
@dynamic conditions;
@dynamic medications;
@dynamic immunizations;
@dynamic results;
@dynamic vitalSigns;
@dynamic allergies;
@dynamic procedures;

#pragma mark - class methods
+ (HRMPatient *)instanceWithDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context {
    
    // create patient
    HRMPatient *patient = [HRMPatient instanceInContext:context];
    __block id object = nil;
    
    // load basic data
    object = [dictionary objectForKey:@"first"];
    if (object && [object isKindOfClass:[NSString class]]) {
        patient.firstName = object;
    }
    object = [dictionary objectForKey:@"last"];
    if (object && [object isKindOfClass:[NSString class]]) {
        patient.lastName = object;
    }
    object = [dictionary objectForKey:@"race"];
    if (object && [object isKindOfClass:[NSString class]]) {
        patient.race = object;
    }
    object = [dictionary objectForKey:@"ethnicity"];
    if (object && [object isKindOfClass:[NSString class]]) {
        patient.ethnicity = object;
    }
    object = [dictionary objectForKey:@"birthdate"];
    if (object && [object isKindOfClass:[NSNumber class]]) {
        NSTimeInterval stamp = [object doubleValue];
        patient.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:stamp];
    }
    object = [dictionary objectForKey:@"gender"];
    if (object && [object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@"M"]) {
            patient.gender = [NSNumber numberWithUnsignedInteger:HRPatientGenderMale];
        }
        else if ([object isEqualToString:@"F"]) {
            patient.gender = [NSNumber numberWithUnsignedInteger:HRPatientGenderFemale];
        }
    }
    
    // define block for iterating over collections
    void (^collectionBlock) (HRMEntryType, NSString *) = ^(HRMEntryType type, NSString *key) {
        object = [dictionary objectForKey:key];
        if (object && [object isKindOfClass:[NSArray class]]) {
            [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                    HRMEntry *entry = [HRMEntry
                                       instanceWithDictionary:obj
                                       type:type
                                       inContext:context];
                    [patient addEntriesObject:entry];
                }
            }];
        }
    };
    
    // encounters
    collectionBlock(HRMEntryTypeEncounter, @"encounters");
    collectionBlock(HRMEntryTypeCondition, @"conditions");
    collectionBlock(HRMEntryTypeAllergy, @"allergies");
    collectionBlock(HRMEntryTypeMedication, @"medications");
    collectionBlock(HRMEntryTypeProcedure, @"procedures");
    collectionBlock(HRMEntryTypeResult, @"results");
    collectionBlock(HRMEntryTypeVitalSign, @"vital_signs");
    collectionBlock(HRMEntryTypeImmunization, @"immunizations");
    
    // return
    return patient;
    
}
+ (NSArray *)patientsInContext:(NSManagedObjectContext *)context {
    static NSSortDescriptor *sort = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sort = [[NSSortDescriptor alloc] initWithKey:@"dateOfBirth" ascending:NO];
    });
    return [self allInContext:context sortDescriptor:sort];
}
+ (void)setSelectedPatient:(HRMPatient *)patient {
//    NSAssert([patient managedObjectContext] == [HRAppDelegate managedObjectContext], @"The global patient must exist in the main application context");
    selectedPatient = patient;
}
+ (HRMPatient *)selectedPatient {
    return selectedPatient;
}

#pragma mark - attribute overrides
- (NSString *)compositeName {
    [self willAccessValueForKey:@"compositeName"];
    NSString *name = [NSString
                      stringWithFormat:@"%@ %@",
                      self.firstName,
                      self.lastName];
    [self didAccessValueForKey:@"compositeName"];
    return name;
}
- (NSString *)genderString {
    [self willAccessValueForKey:@"genderString"];
    NSString *gender = @"Unknown";
    if ([self.gender unsignedIntegerValue] == HRPatientGenderMale) {
        gender = @"Male";
    }
    else if ([self.gender unsignedIntegerValue] == HRPatientGenderFemale) {
        gender = @"Female";
    }
    [self didAccessValueForKey:@"genderString"];
    return gender;
}
- (NSString *)dateOfBirthString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
    });
    [self willAccessValueForKey:@"dateOfBirthString"];
    NSString *string = [formatter stringFromDate:self.dateOfBirth];
    [self didAccessValueForKey:@"dateOfBirthString"];
    return string;
}

#pragma mark - object methods
- (UIImage *)patientImage {
    return [UIImage imageNamed:[NSString stringWithFormat:@"UserImage-%@-%@", self.lastName, self.firstName]];
}
- (DDXMLElement *)timelineXMLDocument {
    
    // create root
    DDXMLElement *data = [DDXMLElement elementWithName:@"data"];
    [data addAttribute:[DDXMLElement attributeWithName:@"wiki-url" stringValue:@"http://simile.mit.edu/shelf/"]];
    [data addAttribute:[DDXMLElement attributeWithName:@"wiki-section" stringValue:@"Simile Monet Timeline"]];
    
    // create events
    [self.entries enumerateObjectsUsingBlock:^(HRMEntry *entry, BOOL *stop) {
        DDXMLElement *event = [entry timelineXMLElement];
        [data addChild:event];
    }];
    
    // return
    return data;
    
}

@end
