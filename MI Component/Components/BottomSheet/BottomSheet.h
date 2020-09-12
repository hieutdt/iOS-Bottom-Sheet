//
//  MIBottomSheet.h
//  MI Component
//
//  Created by HieuTDT on 9/6/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomSheet : UIView

@property (nonatomic, assign) BOOL canExpanded;

- (void)setContentView:(UIView *)contentView;

@end

NS_ASSUME_NONNULL_END
