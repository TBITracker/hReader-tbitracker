//
//  HRAppDelegate.m
//  HReader
//
//  Created by Marshall Huss on 11/14/11.
//  Copyright (c) 2011 MITRE Corporation. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "HRAppDelegate.h"
#import "HRPasscodeWarningViewController.h"
#import "HRPrivacyViewController.h"

#import "PINCodeViewController.h"

#import "HRMPatient.h"

@interface HRAppDelegate ()
- (void)presentPasscodeCreateController;
- (void)presentPasscodeVerifyControllerIfNecessary;
@end

@implementation HRAppDelegate

@synthesize window = __window;

#pragma mark - class methods
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    static NSPersistentStoreCoordinator *coordinator = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSError *error = nil;
        NSPersistentStore *store = [coordinator
                                    addPersistentStoreWithType:NSInMemoryStoreType
                                    configuration:nil
                                    URL:nil
                                    options:nil
                                    error:&error];
        NSAssert(store, @"Unable to add persistent store\n%@", error);
    });
    return coordinator;
}
+ (NSManagedObjectContext *)managedObjectContext {
    static NSManagedObjectContext *context = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    });
    return context;
}

#pragma mark - object methods
- (void)dealloc {
    self.window = nil;
    [super dealloc];
}

- (void)presentPasscodeCreateController {
#if !defined (DEBUG)// || 1
    if (![PINCodeViewController isPersistedPasscodeSet]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PINCodeStoryboard" bundle:nil];
        UINavigationController *navigation = [storyboard instantiateInitialViewController];
        PINCodeViewController *PIN = [navigation.viewControllers objectAtIndex:0];
        PIN.mode = PINCodeViewControllerModeCreate;
        PIN.title = @"Set Passcode";
        PIN.messageText = @"Enter a passcode";
        PIN.confirmText = @"Verify passcode";
        PIN.errorText = @"The passcodes do not match";
        PIN.verifyBlock = ^(NSString *code) {
            if ([code length] == 6) {
                [PINCodeViewController setPersistedPasscode:code];
                return YES;
            }
            else {
                return NO;
            }
        };
        UIViewController *controller = self.window.rootViewController;
        if (controller.presentedViewController) {
            [controller dismissModalViewControllerAnimated:NO];
        }
        [controller presentModalViewController:navigation animated:NO];
    }
#endif
}
- (void)presentPasscodeVerifyControllerIfNecessary {
#if !defined(DEBUG)// || 1
    static BOOL visible = NO;
    if (!visible && [PINCodeViewController isPersistedPasscodeSet]) {
        visible = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PINCodeStoryboard" bundle:nil];
        UINavigationController *navigation = [storyboard instantiateInitialViewController];
        PINCodeViewController *PIN = [navigation.viewControllers objectAtIndex:0];
        PIN.mode = PINCodeViewControllerModeVerify;
        PIN.title = @"Enter Passcode";
        PIN.messageText = @"Enter your passcode";
        PIN.errorText = @"Incorrect passcode";
        PIN.verifyBlock = ^(NSString *code) {
            BOOL correct = [PINCodeViewController isPasscodeValid:code];
            visible = !correct;
            return correct;
        };
        UIViewController *controller = self.window.rootViewController;
        if (controller.presentedViewController) {
            [controller dismissModalViewControllerAnimated:NO];
        }
        [controller presentModalViewController:navigation animated:NO];
    }
#endif
}

#pragma mark - application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // test flight
#if !defined(DEBUG)// || 1
    [TestFlight takeOff:[HRConfig testFlightTeamToken]];
#endif
    
    // load patients if we don't have any yet
    NSManagedObjectContext *context = [HRAppDelegate managedObjectContext];
    if ([HRMPatient countInContext:context] == 0) {
        NSArray *names = [NSArray arrayWithObjects:@"hs", @"js", @"ms", @"ss", @"ts", nil];
        [names enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSURL *URL = [[NSBundle mainBundle] URLForResource:obj withExtension:@"json"];
            NSData *data = [NSData dataWithContentsOfURL:URL];
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            /*HRMPatient *patient = */[HRMPatient instanceWithDictionary:object inContext:context];
//            NSLog(@"%@", );
//            [patient timelineXMLDocument];
            
        }];
        NSError *error = nil;
        BOOL save = [context save:&error];
        NSAssert(save, @"Unable to import patients\n%@", error);
    }
    NSArray *patients = [HRMPatient patientsInContext:context];
    [HRMPatient setSelectedPatient:[patients objectAtIndex:0]];
    
    // show window so we can present stuff
    [self.window makeKeyAndVisible];
    
    // show pin code
    if ([PINCodeViewController isPersistedPasscodeSet]) {
        [self presentPasscodeVerifyControllerIfNecessary];
    }
    else {
        [self presentPasscodeCreateController];
        UIAlertView *alert = [[[UIAlertView alloc]
                               initWithTitle:@"Welcome"
                               message:@"Before you star using hReader, you must set a passcode."
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil]
                              autorelease];
        [alert show];
    }
    
    // return
    return YES;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    //    [TestFlight passCheckpoint:@"Window Hidden"];
    //    self.window.hidden = YES;
    //    [self.window.rootViewController dismissModalViewControllerAnimated:NO];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self presentPasscodeVerifyControllerIfNecessary];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    //    [TestFlight passCheckpoint:@"Window Unhidden"];
    //    self.window.hidden = NO;
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //    [self.privacyViewController.view removeFromSuperview];
    //    [TestFlight passCheckpoint:@"Window Unhidden"];
    //    self.window.hidden = NO;
    //    [TestFlight passCheckpoint:@"PIN Code Presented"];
    //    GCPINViewController *PIN = [self pinCodeViewController];
    //    [PIN presentFromViewController:self.window.rootViewController animated:NO];
}
- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    [HRConfig setPasscodeEnabled:YES];
}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    
}


#pragma mark - Privacy warning

//- (void)showPrivacyWarning {
//    if (![HRConfig hasLaunched]) {
//        HRPasscodeWarningViewController *warningViewController = [[HRPasscodeWarningViewController alloc] initWithNibName:nil bundle:nil];
//        [self.window.rootViewController presentModalViewController:warningViewController animated:NO];
//        [warningViewController release];
//    }
//}
//
//
//- (void)setupPrivacyView {
//    self.privacyViewController = [[[HRPrivacyViewController alloc] initWithNibName:nil bundle:nil] autorelease];
//}

@end
