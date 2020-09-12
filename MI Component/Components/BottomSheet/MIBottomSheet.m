//
//  MIBottomSheet.m
//  MI Component
//
//  Created by HieuTDT on 9/6/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "BottomSheet.h"
#import "UIView+Additions.h"

@interface BottomSheet()

@property (nonatomic, strong) UIView *topLine;

@end

@implementation BottomSheet

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)customInit {
    _topLine = [[UIView alloc] init];
    [self addSubview:_topLine];
    
    _topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [_topLine.topAnchor constraintEqualToAnchor:self.topAnchor constant:5].active = YES;
    [_topLine.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_topLine.widthAnchor constraintEqualToConstant:100].active = YES;
    [_topLine.heightAnchor constraintEqualToConstant:1].active = YES;
    
    _topLine.backgroundColor = [UIColor lightGrayColor];
    _topLine.layer.cornerRadius = 1;
    
    [self roundCorner:UIRectCornerTopLeft | UIRectCornerTopRight radius:20];
    [self dropShadowWithRadius:10];
    
    // Add Pan gesture recognizer
    UIPanGestureRecognizer *viewPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanned:)];
    viewPan.delaysTouchesBegan = NO;
    viewPan.delaysTouchesEnded = NO;
    
    [self addGestureRecognizer:viewPan];
}

#pragma mark - PanGesture handle

- (void)viewPanned:(UIPanGestureRecognizer *)panRecognizer {
    CGPoint translation = [panRecognizer translationInView:self];
    NSLog(@"User has dragged %f points vertically!", translation.y);
}


@end
