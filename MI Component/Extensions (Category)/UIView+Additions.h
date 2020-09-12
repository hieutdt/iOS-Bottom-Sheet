//
//  UIView+Additions.h
//  MI Component
//
//  Created by HieuTDT on 9/6/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Additions)

- (void)dropShadowWithRadius:(CGFloat)shadowRadius;

+ (UIWindow *)keyWindow;

@end

NS_ASSUME_NONNULL_END
