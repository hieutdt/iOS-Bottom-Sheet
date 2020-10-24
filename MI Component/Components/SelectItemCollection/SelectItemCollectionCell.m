//
//  SelectItemCollectionCell.m
//  MI Component
//
//  Created by HieuTDT on 9/19/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "SelectItemCollectionCell.h"
#import "VerticalIconTextButton.h"

@interface SelectItemCollectionCell()

@property (nonatomic, strong) VerticalIconTextButton *button;

@property (nonatomic, strong) SelectItemModel *viewModel;

@end

@implementation SelectItemCollectionCell

#pragma mark - Lifecycle

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

- (void)customInit {
    _viewModel = [[SelectItemModel alloc] init];
    _button = [[VerticalIconTextButton alloc] init];
    
    [self addSubview:_button];
    
    /// Layout
    _button.translatesAutoresizingMaskIntoConstraints = NO;
    [_button.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_button.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [_button.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_button.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

- (BOOL)isSelected {
    return _button.isSelected;
}

#pragma mark - Setters

- (void)setNormalImageName:(NSString *)normalImgName
         selectedImageName:(NSString *)selectedImgName
                     title:(NSString *)title
                 imageSize:(CGFloat)size {
    
    self.viewModel.normalImageName = normalImgName;
    self.viewModel.selectedImageName = selectedImgName;
    self.viewModel.title = title;
    
    [self layoutIfNeeded];
}

- (void)setModel:(SelectItemModel *)model {
    self.viewModel = model;
    
    [_button setImage:[UIImage imageNamed:self.viewModel.normalImageName]];
    [_button setSelectedImage:[UIImage imageNamed:self.viewModel.selectedImageName]];
    [_button setText:self.viewModel.title];
    [_button setTappedAction:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCollectionCell:)]) {
            [self.delegate didSelectCollectionCell:self];
        }
    }];
    
    [self layoutIfNeeded];
}


@end
