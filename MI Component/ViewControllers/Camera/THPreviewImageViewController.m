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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end

@implementation THPreviewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
}

- (void)configureUI {
    if (_imageForPreview) {
        // Fix orientation
        _imageForPreview = [_imageForPreview fixOrientation];
        
        // Apply filter
        _imageForPreview = [_imageForPreview addFilter:kFilterTypeMono];
        
        // Set to image view
        [self.imageView setImage:_imageForPreview];
    }
    
    
    self.view.backgroundColor = UIColor.blackColor;
    
    CGFloat whRatio = SCREEN_WIDTH / SCREEN_HEIGHT;
    _imageViewHeightConstraint.constant = SCREEN_WIDTH / whRatio;

    [self.view layoutIfNeeded];
}

@end
