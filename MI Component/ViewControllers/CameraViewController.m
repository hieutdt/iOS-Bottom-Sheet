//
//  CameraViewController.m
//  MI Component
//
//  Created by HieuTDT on 9/26/20.
//  Copyright © 2020 HieuTDT. All

#import "CameraViewController.h"
#import "THPreviewImageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MI_Component-Swift.h"

#define kBottomViewHeight 120

@interface CameraViewController() <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) CALayer *previewLayer;

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice *captureDevice;
@property (assign, nonatomic) BOOL takePhoto;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Lock orientation in this view controller
    [AppUtility lockOrientation:UIInterfaceOrientationMaskLandscapeRight
                    andRotateTo:UIInterfaceOrientationLandscapeRight];
    
    // Prepare camera
    [self prepareCamera];
}

#pragma mark - Configure UI

- (void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [_takePhotoButton setBackgroundColor:UIColor.clearColor];
    [_takePhotoButton setBackgroundImage:[UIImage imageNamed:@"capture"] forState:UIControlStateNormal];
    [_takePhotoButton setBackgroundImage:[UIImage imageNamed:@"capture_tap"] forState:UIControlStateHighlighted];
    
    _bottomView.backgroundColor = [UIColor redColor];
}

- (void)_createPreviewUI {
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.backgroundColor = UIColor.blackColor.CGColor;
    self.previewLayer.contentsGravity = kCAGravityCenter;
    
    [self.view.layer addSublayer:_previewLayer];
    self.previewLayer.frame = CGRectMake(self.view.layer.frame.origin.x,
                                         self.view.layer.frame.origin.y,
                                         self.view.layer.frame.size.width,
                                         self.view.layer.frame.size.height);

    [self.view bringSubviewToFront:self.bottomView];
    
    [self _drawCarBorder];
}

- (void)_drawCarBorder {
    CGRect bounds = self.view.bounds;
    
    // Create path for draw
    CGRect dRect = CGRectMake(bounds.size.width * 0.25,
                            bounds.size.height * 0.25,
                            bounds.size.width * 0.5,
                            bounds.size.height * 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:dRect];
    [[UIColor whiteColor] set];
    [path stroke];
    [path closePath];
    
    // Create shape layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath:path.CGPath];
    [shapeLayer setStrokeColor:UIColor.whiteColor.CGColor];
    [shapeLayer setLineWidth:2.f];
    [shapeLayer setFillColor:UIColor.clearColor.CGColor];
    shapeLayer.backgroundColor = UIColor.cyanColor.CGColor;
    
    // Add layer to the view layer
    [self.view.layer addSublayer:shapeLayer];
}

#pragma mark - Prepare Camera

- (void)prepareCamera {
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    NSArray<AVCaptureDevice *> *availableDevices = [[AVCaptureDeviceDiscoverySession
                              discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                              mediaType:AVMediaTypeVideo
                              position:AVCaptureDevicePositionBack] devices];
    
    _captureDevice = [availableDevices firstObject];
    
    [self _beginSession];
}

- (void)_beginSession {
    
    // Add capture Input
    @try {
        AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice
                                                                                         error:nil];
        [_session addInput:captureDeviceInput];
        
    } @catch (NSError *err) {
        NSLog(@"%@", err.localizedDescription);
    }
    
    // Init preview UI
    [self _createPreviewUI];
    
    // Running session
    [self.session startRunning];
    
    // Add Data Ouput for session
    AVCaptureVideoDataOutput *dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [dataOutput setVideoSettings:@{ (NSString *)kCVPixelBufferPixelFormatTypeKey :
                                        [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] }];
    dataOutput.alwaysDiscardsLateVideoFrames = YES;
    
    if ([self.session canAddOutput:dataOutput]) {
        [self.session addOutput:dataOutput];
    }
    
    // Commit this configuration
    [self.session commitConfiguration];
    
    // Add Delegate on a background serial queue
    dispatch_queue_t serialQueue = dispatch_queue_create("Mioto.CaptureQueue", DISPATCH_QUEUE_SERIAL);
    [dataOutput setSampleBufferDelegate:self queue:serialQueue];
}

#pragma mark - Action

- (IBAction)captureButtonTapped:(id)sender {
    self.takePhoto = YES;
}


#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    
    if (self.takePhoto) {
        self.takePhoto = NO;
        
        // Get image from buffer and present in PreviewImageViewController
        UIImage *image = [self _getImageFromSampleBuffer:sampleBuffer];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                THPreviewImageViewController *vc = [[THPreviewImageViewController alloc] init];
                vc.imageForPreview = image;
                
                [self presentViewController:vc animated:YES completion:nil];
            });
        }
    }
}

- (UIImage *)_getImageFromSampleBuffer:(CMSampleBufferRef)buffer {
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(buffer);
    
    if (pixelBuffer) {
        CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
        CIContext *context = [[CIContext alloc] init];
        
        CGRect imageRect = CGRectMake(0, 0,
                                       CVPixelBufferGetWidth(pixelBuffer),
                                       CVPixelBufferGetHeight(pixelBuffer));
        
        CGImageRef image = [context createCGImage:ciImage fromRect:imageRect];
        if (image) {
            return [UIImage imageWithCGImage:image
                                       scale:UIScreen.mainScreen.scale
                                 orientation:UIImageOrientationRight];
        }
    }
    
    return nil;
}

@end
