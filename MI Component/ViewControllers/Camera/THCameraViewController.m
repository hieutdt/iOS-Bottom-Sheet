//
//  THCameraViewController.m
//  MI Component
//
//  Created by HieuTDT on 10/24/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "THCameraViewController.h"
#import "CameraSessionView.h"
#import "MI_Component-Swift.h"
#import "THPreviewImageViewController.h"

@interface THCameraViewController () <CACameraSessionDelegate>

@property (nonatomic, strong) CameraSessionView *cameraView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation THCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Lock orientation in this view controller
    [AppUtility lockOrientation:UIInterfaceOrientationMaskPortrait
                    andRotateTo:UIInterfaceOrientationPortrait];
    
    [self _setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)_setUpUI {
    // Init camera view
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    _cameraView.delegate = self;
    [self.view addSubview:_cameraView];
    
    // Layout
    [_cameraView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_cameraView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_cameraView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_cameraView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    // Configure camera view
    [_cameraView setTopBarColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [_cameraView hideFlashButton];
    [_cameraView hideDismissButton];
    [_cameraView hideCameraToggleButton];
    
    [self _drawCarRect];
}

- (void)_drawCarRect {
    CGRect bounds = self.view.bounds;
    
    // Create path for draw
    CGRect dRect = CGRectMake(bounds.size.width * 0.2,
                            bounds.size.height * 0.2,
                            bounds.size.width * 0.6,
                            bounds.size.height * 0.6);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:dRect];
    [[UIColor whiteColor] set];
    [path stroke];
    [path closePath];
    
    // Create shape layer
    _shapeLayer = [[CAShapeLayer alloc] init];
    [_shapeLayer setPath:path.CGPath];
    [_shapeLayer setStrokeColor:UIColor.whiteColor.CGColor];
    [_shapeLayer setLineWidth:2.f];
    [_shapeLayer setFillColor:UIColor.clearColor.CGColor];
    _shapeLayer.backgroundColor = UIColor.cyanColor.CGColor;
    
    // Add layer to the view layer
    [self.view.layer addSublayer:_shapeLayer];
}

#pragma mark - CACameraSessionDelegate

- (void)didCaptureImage:(UIImage *)image {
    THPreviewImageViewController *vc = [[THPreviewImageViewController alloc] init];
    [vc setImageForPreview:image];
    
    [self presentViewController:vc animated:true completion:nil];
}

@end
