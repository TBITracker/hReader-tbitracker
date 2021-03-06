//
//  HRPeopleSetupViewController.h
//  HReader
//
//  Created by Caleb Davenport on 5/29/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "HRGridTableView.h"

@interface HRPeopleSetupViewController : UIViewController <HRGridTableViewDelegate, HRGridTableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet HRGridTableView *gridView;
@property (nonatomic, strong) IBOutlet UIView *emptyCellView;

@property (nonatomic, strong) IBOutlet UIButton *spouseButton;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *emptyCellButtons;

@property (nonatomic, weak) IBOutlet UIView *firstView;
@property (nonatomic, weak) IBOutlet UIButton *meButton;

- (IBAction)meButtonPress:(id)sender;
- (IBAction)spouseButtonPress:(id)sender;
- (IBAction)childButtonPress:(id)sender;
- (IBAction)familyMemberButtonPress:(id)sender;
- (IBAction)viewInMainInterface:(id)sender;

@end
