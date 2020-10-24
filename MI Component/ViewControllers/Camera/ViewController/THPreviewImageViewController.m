//
//  PreviewImageViewController.m
//  MI Component
//
//  Created by HieuTDT on 10/5/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "THPreviewImageViewController.h"
#import "UIImage+Filter.h"

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

@interface THPreviewImageViewController ()

@property (weak, nonatomic) IBOutlet UIView *imageViewContainer;
@property (weak, nonatomic) IBOutlet UIView *filterViewContainer;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterViewHeightConstraint;

@end

@implementation THPreviewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageForPreview = [UIImage imageNamed:@"car"];
    
    [self configureUI];
}

#pragma mark - Configure UI

- (void)configureUI {
    if (_imageForPreview) {
        // Change orientation to landscape.
//        _imageForPreview = [_imageForPreview changeImageOrientation:UIImageOrientationLeft];
        
        // Set image to image view.
        self.imageView.image = _imageForPreview;
    }
    
    self.view.backgroundColor = UIColor.blackColor;
    self.imageViewContainer.backgroundColor = UIColor.blueColor;
    self.filterViewContainer.backgroundColor = UIColor.blackColor;
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = UIColor.whiteColor;
    
    CGFloat whRatio = 4/3.f;
    _imageViewHeightConstraint.constant = SCREEN_WIDTH / whRatio;
    
    // Default is hide filter view
    [self hideFilterView];

    [self.view layoutIfNeeded];
}

- (void)_drawCarRectInImageView {
    CGRect bounds = self.view.bounds;
    
    // Create path for draw
    
}

#pragma mark - Utils

- (void)showFilterView {
    self.filterViewHeightConstraint.constant = 150;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutSubviews];
    }];
}

- (void)hideFilterView {
    self.filterViewHeightConstraint.constant = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutSubviews];
    }];
}

@end
