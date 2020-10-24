//
//  SelectItemCollection.h
//  MI Component
//
//  Created by HieuTDT on 9/19/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SelectItemCollection;

@protocol SelectItemCollectionDelegate <NSObject>

- (void)collection:(SelectItemCollection *)collection
didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

@interface SelectItemCollection : UIView

@property (nonatomic, assign) id<SelectItemCollectionDelegate> delegate;

- (instancetype)initWithViewModels:(NSArray<SelectItemModel *> *)models;

- (void)setViewModels:(NSMutableArray<SelectItemModel *> *)viewModels;

- (BOOL)itemAtIndexPathIsChosen:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
