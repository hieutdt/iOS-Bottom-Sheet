//
//  UIImage+Filter.h
//  MI Component
//
//  Created by HieuTDT on 10/24/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kFilterTypeChrome = @"CIPhotoEffectChrome";
static NSString *kFilterTypeFade = @"CIPhotoEffectFade";
static NSString *kFilterTypeInstant = @"CIPhotoEffectInstant";
static NSString *kFilterTypeMono = @"CIPhotoEffectMono";
static NSString *kFilterTypeNoir = @"CIPhotoEffectNoir";
static NSString *kFilterTypeProcess = @"CIPhotoEffectProcess";
static NSString *kFilterTypeTonal = @"CIPhotoEffectTonal";
static NSString *kFilterTypeTransfer = @"CIPhotoEffectTransfer";

@interface UIImage (Filter)

- (UIImage *)addFilter:(NSString *)filterType;

- (UIImage *)fixOrientation;

@end

NS_ASSUME_NONNULL_END
