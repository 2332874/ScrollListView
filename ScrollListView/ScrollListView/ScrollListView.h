//
//  ScrollListView.h
//  ScrollListView
//
//  Created by 井上友希 on 2016/01/09.
//  Copyright © 2016年 井上友希. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const Text = @"TEXT";

@class ScrollListView;

@protocol ScrollListViewDelegate <NSObject>

@optional
- (void)scrollListView:(ScrollListView*)ScrollListView didSelectListRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ScrollListViewDataSource <NSObject>

@required
- (NSArray<NSDictionary *> *)scrollListView:(ScrollListView*)ScrollListView cellForRowShowDataAtCurrentPage:(NSUInteger)currentPage;

@end

@interface ScrollListView : UIView

@property (nonatomic, assign) id<ScrollListViewDelegate>delegate;

@property (nonatomic, assign) id<ScrollListViewDataSource>dataSource;

@property (nonatomic) NSUInteger currentPage;
@property NSUInteger scrollPages;

@end
