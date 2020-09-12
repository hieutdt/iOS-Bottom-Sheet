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
@property (nonatomic, assign) UIView *contentView;

@end

@implementation BottomSheet

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    self.alpha = 1;
    self.backgroundColor = [UIColor whiteColor];
    
    _topLine = [[UIView alloc] init];
    [self addSubview:_topLine];
    
    _topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [_topLine.topAnchor constraintEqualToAnchor:self.topAnchor constant:15].active = YES;
    [_topLine.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_topLine.widthAnchor constraintEqualToConstant:100].active = YES;
    [_topLine.heightAnchor constraintEqualToConstant:3].active = YES;
    
    _topLine.backgroundColor = [UIColor lightGrayColor];
    _topLine.layer.cornerRadius = 1;
    
    [self dropShadowWithRadius:10];
    [self setClipsToBounds:YES];
    self.layer.cornerRadius = 20.0;
    self.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    
    [self addSubview:_contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor constant:30].active = YES;
    [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5].active = YES;
    [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5].active = YES;
}


@end
