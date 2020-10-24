//
//  SelectItemModel.h
//  MI Component
//
//  Created by HieuTDT on 9/19/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectItemModel : NSObject

@property (nonatomic, strong) NSString *normalImageName;
@property (nonatomic, strong) NSString *selectedImageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;

@end

NS_ASSUME_NONNULL_END
