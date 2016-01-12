//
//  ScrollListCollectionView.m
//  ScrollListView
//
//  Created by 井上友希 on 2016/01/09.
//  Copyright © 2016年 井上友希. All rights reserved.
//

#import "ScrollListCollectionView.h"

@implementation ScrollListCollectionView

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.backgroundColor = [UIColor orangeColor];
        self.pagingEnabled = YES;
        self.bounces = NO;
        
    }
    
    return self;
}

@end
