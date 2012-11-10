
//
//  SpeakPictureType.h
//  HReader
//
//  Created by Kaye, Lindsay M on 9/24/12.
//  Copyright (c) 2012 MITRE Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakPictureType : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UICollectionViewDataSource> {
    UIImageView * imageView;
    UINavigationBar *navBar;
    UINavigationItem *navItem;
}
@property (nonatomic, strong) IBOutlet UIButton *cameraButton;
@property (nonatomic, strong) IBOutlet UIButton * speakButton;
@property (nonatomic, strong) IBOutlet UIButton * textButton;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) IBOutlet UIButton *recordButton;

@property (assign) BOOL thumbsVisible;
@property (nonatomic, strong) NSArray *allImages;
@property (nonatomic, strong) IBOutlet UIScrollView * scrollView;
@property (nonatomic, strong) IBOutlet UIImageView *testImage;

- (IBAction) showHideView:(id)sender;
- (IBAction) launchRecord:(id)sender;
- (IBAction) presentTextBox:(id)sender;
- (IBAction) presentCamera:(id)sender;
- (IBAction) dismissView:(id)sender;
- (IBAction) recordAndSave:(id)sender;

- (void)setupverticalScrollView;

- (BOOL) startCameraControllerFromViewController:(UIViewController*)controller usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate;

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
