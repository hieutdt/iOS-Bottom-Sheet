//
//  UIView+Additions.m
//  MI Component
//
//  Created by HieuTDT on 9/6/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (void)dropShadowWithRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.7f;
}

+ (UIWindow *)keyWindow {
    NSArray<UIWindow *> *windows = [UIApplication sharedApplication].windows;
    
    assert(windows.count > 0);
    
    for (UIWindow *window in windows) {
        if ([window isKeyWindow]) {
            return window;
        }
    }
    
    return windows.firstObject;
}

@end
