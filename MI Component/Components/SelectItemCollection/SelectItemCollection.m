//
//  SelectItemCollection.m
//  MI Component
//
//  Created by HieuTDT on 9/19/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "SelectItemCollection.h"
#import "SelectItemModel.h"
#import "SelectItemCollectionCell.h"

static int kNumberOfItemInSection = 3;
static NSString *kReuseIdentifer = @"SelectItemCollectionCellReuseId";

@interface SelectItemCollection() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectItemCollectionCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray<SelectItemModel *> *viewModels;

@end

@implementation SelectItemCollection

- (instancetype)init {
    self = [super init];
    if (self) {
        [self customInit:@[]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit:@[]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit:@[]];
    }
    return self;
}

- (instancetype)initWithViewModels:(NSArray<SelectItemModel *> *)models {
    self = [super init];
    if (self) {
        [self customInit:models];
    }
    return self;
}

- (void)customInit:(NSArray<SelectItemModel *> *)viewModels {
    self.backgroundColor = [UIColor whiteColor];
    
    self.viewModels = [NSMutableArray arrayWithArray:viewModels];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UILayoutConstraintAxisHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:SelectItemCollectionCell.class
        forCellWithReuseIdentifier:kReuseIdentifer];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self addSubview:_collectionView];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_collectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_collectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [_collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

#pragma mark - Setters

- (void)setViewModels:(NSMutableArray<SelectItemModel *> *)viewModels {
    _viewModels = [NSMutableArray arrayWithArray:viewModels];
    
    [self layoutIfNeeded];
    [_collectionView reloadData];
}

#pragma mark - Getter

- (BOOL)itemAtIndexPathIsChosen:(NSIndexPath *)indexPath {
    SelectItemCollectionCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if (!cell) {
        return NO;
    }
    return [cell isSelected];;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(100, 150);
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger val = self.viewModels.count / kNumberOfItemInSection +  1;
    return val;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (section < self.viewModels.count / kNumberOfItemInSection) {
        return kNumberOfItemInSection;
    } else {
        return self.viewModels.count % kNumberOfItemInSection;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectItemCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifer
                                                                                    forIndexPath:indexPath];
    if (!cell) {
        cell = [[SelectItemCollectionCell alloc] init];
    }
    
    NSInteger index = indexPath.section * kNumberOfItemInSection + indexPath.item;
    SelectItemModel *viewModel = [self.viewModels objectAtIndex:index];
    if (viewModel) {
        [cell setModel:viewModel];
        cell.delegate = self;
        return cell;
    }
    return [[UICollectionViewCell alloc] init];
}

#pragma mark - SelectItemCollectionCellDelegate

- (void)didSelectCollectionCell:(SelectItemCollectionCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(collection:didSelectItemAtIndexPath:)]) {
            [self.delegate collection:self didSelectItemAtIndexPath:indexPath];
        }
    }
}


@end
