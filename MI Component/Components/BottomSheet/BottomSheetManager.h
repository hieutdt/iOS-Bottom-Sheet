//
//  BottomSheetManager.h
//  MI Component
//
//  Created by HieuTDT on 9/7/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomSheetManager : NSObject

+ (BottomSheetManager *)instance;

- (void)showBottomSheetWithContent:(UIView *)contentView;

- (void)showBottomSheetWithContent:(UIView *)contentView
                            height:(CGFloat)contentHeight
                       canExpanded:(BOOL)canExpanded;

- (void)hideVisibleBottomSheet;

@end

NS_ASSUME_NONNULL_END
