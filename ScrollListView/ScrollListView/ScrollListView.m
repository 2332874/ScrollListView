//
//  ScrollListView.m
//  ScrollListView
//
//  Created by 井上友希 on 2016/01/09.
//  Copyright © 2016年 井上友希. All rights reserved.
//

#import "ScrollListView.h"
#import "ScrollListCollectionView.h"

static NSString *const ReuseIdentifier = @"CELL";

@interface ScrollListView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

@property ScrollListCollectionView *scrollListCollectionView;

@property BOOL isFirstFlg;
@property NSArray *showListData;

@end

@implementation ScrollListView
#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.frame = frame;
        self.currentPage = 0;
        self.scrollPages = 0;
        self.isFirstFlg = YES;
        
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.scrollListCollectionView = [[ScrollListCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionViewFlowLayout];
        [self.scrollListCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
        
        [self addSubview:self.scrollListCollectionView];
        
        self.scrollListCollectionView.delegate = self;
        self.scrollListCollectionView.dataSource = self;
        
    }
    
    return self;
    
}

#pragma mark -
- (void)setCurrentPage:(NSUInteger)currentPage {
    
    NSLog(@"%s", __FUNCTION__);
    
    _currentPage = currentPage;
    
    if (self.currentPage > 0 && self.isFirstFlg) {
        [self.scrollListCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.isFirstFlg = NO;
    }
    
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.scrollPages;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s %@", __FUNCTION__, NSStringFromCGRect(collectionView.frame));
    
    self.currentPage = indexPath.row;
    
    if ([self.dataSource respondsToSelector:@selector(scrollListView:cellForRowShowDataAtCurrentPage:)]) {
        self.showListData = [self.dataSource scrollListView:self cellForRowShowDataAtCurrentPage:self.currentPage];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            [view removeFromSuperview];
        }
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:collectionView.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [cell.contentView addSubview:tableView];
    
    return cell;
    
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
    
    NSLog(@"%s %@", __FUNCTION__, NSStringFromCGSize(size));
    
    return size;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.showListData) {
        return self.showListData.count + 1;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    }
    
    cell.textLabel.text = @"";
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"PageNumber=%ld", self.currentPage];
        cell.backgroundColor = [UIColor cyanColor];
    } else {
        
        NSDictionary *data = self.showListData[indexPath.row - 1];
        if (data) {
            
            cell.textLabel.text = data[Text];
            
        }
        
    }
    
    return cell;
    
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.delegate respondsToSelector:@selector(scrollListView:didSelectListRowAtIndexPath:)]) {
        [self.delegate scrollListView:self didSelectListRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
