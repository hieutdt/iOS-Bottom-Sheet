//
//  VerticalIconTextButton.m
//  MiOTO
//
//  Created by Trần Đình Tôn Hiếu on 4/12/20.
//  Copyright © 2020 MiOTO. All rights reserved.
//

#import "VerticalIconTextButton.h"

@interface VerticalIconTextButton ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, assign) BOOL canSelect;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) dispatch_block_t tappedBlock;

@end

@implementation VerticalIconTextButton

- (void)customInit {
    [self.titleLabel removeFromSuperview];
    [self.imageView removeFromSuperview];
    
    _label = [[UILabel alloc] init];
    _icon = [[UIImageView alloc] init];
    _isSelected = NO;
    _canSelect = NO;
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 7;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.label];
    [self addSubview:self.icon];
    
    [self.icon.topAnchor constraintEqualToAnchor:self.topAnchor constant:5].active = YES;
    [self.icon.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5].active = YES;
    [self.icon.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5].active = YES;
    [self.icon.heightAnchor constraintEqualToConstant:90].active = YES;
    
    [self.label.topAnchor constraintEqualToAnchor:self.icon.bottomAnchor constant:5].active = YES;
    [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5].active = YES;
    self.label.numberOfLines = 2;
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self addTarget:self action:@selector(tapping) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(touchUpOutside) forControlEvents:UIControlEventTouchCancel];
}

- (instancetype)init {
    self = [super init];
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

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                 tappedAction:(dispatch_block_t)action {
    self = [super init];
    if (self) {
        [self setImage:image title:title tappedAction:action];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage
                        title:(NSString *)title
                   isSelected:(BOOL)isSelected {
    self = [super init];
    if (self) {
        [self setImage:normalImage
         selectedImage:selectedImage
                 title:title
            isSelected:isSelected];
    }
    return self;
}

#pragma mark - Setter

- (void)setImage:(UIImage *)normalImage
   selectedImage:(UIImage *)selectedImage
           title:(NSString *)title
      isSelected:(BOOL)isSelected {
#if DEBUG
    assert(self);
#endif
    
    if (!self) {
        return;
    }
    
    self.normalImage = normalImage;
    self.selectedImage = selectedImage;
    self.isSelected = isSelected;
    self.canSelect = YES;
    
    [self.label setText:title];
    
    if (self.isSelected) {
        [self.icon setImage:selectedImage];
    } else {
        [self.icon setImage:normalImage];
    }
}

- (void)setImage:(UIImage *)image
           title:(NSString *)title
    tappedAction:(dispatch_block_t)action {
#if DEBUG
    assert(self);
#endif
    
    if (!self) {
        return;
    }
    
    self.normalImage = image;
    self.selectedImage = image;
    self.tappedBlock = action;
    [self.label setText:title];
    [self.icon setImage:image];
    self.canSelect = NO;
}

- (void)setTappedAction:(dispatch_block_t)tappedHandler {
    self.canSelect = NO;
    _tappedBlock = tappedHandler;
}

- (void)setImage:(UIImage *)image {
    if (image) {
        self.normalImage = image;
        [self.icon setImage:image];
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    if (selectedImage) {
        self.canSelect = YES;
        _selectedImage = selectedImage;
    }
}

- (void)setText:(NSString *)text {
    [self.label setText:text];
}

- (void)setSelected:(BOOL)selected {
    _isSelected = selected;
    if (_isSelected) {
        [self.icon setImage:self.selectedImage];
    } else {
        [self.icon setImage:self.normalImage];
    }
}

#pragma mark - UIControlEventHandlers

- (void)tapping {
    self.backgroundColor = [UIColor colorWithRed:210/255.f green:219/255.f blue:229/255.f alpha:1];
}

- (void)touchUpOutside {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)touchUpInside {
    self.backgroundColor = [UIColor whiteColor];
    
    if (self.tappedBlock && !self.canSelect) {
        self.tappedBlock();
    } else {
        self.canSelect = YES;
        /// Toggle selected
        self.selected = !self.selected;
    }
}

@end
