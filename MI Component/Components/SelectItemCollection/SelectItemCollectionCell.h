//
//  SelectItemCollectionCell.h
//  MI Component
//
//  Created by HieuTDT on 9/19/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SelectItemCollectionCell;

@protocol SelectItemCollectionCellDelegate <NSObject>

- (void)didSelectCollectionCell:(SelectItemCollectionCell *)cell;

@end

@interface SelectItemCollectionCell : UICollectionViewCell

@property (nonatomic, assign) id<SelectItemCollectionCellDelegate> delegate;

- (void)setNormalImageName:(NSString *)normalImgName
         selectedImageName:(NSString *)selectedImgName
                     title:(NSString *)title
                 imageSize:(CGFloat)size;

- (void)setModel:(SelectItemModel *)model;

- (BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
