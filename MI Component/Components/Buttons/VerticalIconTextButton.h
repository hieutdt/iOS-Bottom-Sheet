//
//  VerticalIconTextButton.h
//  MiOTO
//
//  Created by Trần Đình Tôn Hiếu on 4/12/20.
//  Copyright © 2020 MiOTO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerticalIconTextButton : UIButton

@property (nonatomic, assign) BOOL isSelected;

#pragma mark - Init

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                 tappedAction:(dispatch_block_t)action;

- (instancetype)initWithImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage
                        title:(NSString *)title
                   isSelected:(BOOL)isSelected;

#pragma mark - Setters

- (void)setImage:(UIImage *)normalImage
   selectedImage:(UIImage *)selectedImage
           title:(NSString *)title
      isSelected:(BOOL)isSelected;

- (void)setImage:(UIImage *)image
           title:(NSString *)title
    tappedAction:(dispatch_block_t)action;

- (void)setTappedAction:(dispatch_block_t)tappedHandler;

- (void)setImage:(UIImage *)image;

- (void)setSelectedImage:(UIImage *)selectedImage;

- (void)setText:(NSString *)text;

- (void)setSelected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
