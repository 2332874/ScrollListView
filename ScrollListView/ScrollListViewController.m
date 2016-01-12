//
//  ScrollListViewController.m
//  ScrollListView
//
//  Created by 井上友希 on 2016/01/09.
//  Copyright © 2016年 井上友希. All rights reserved.
//

#import "ScrollListViewController.h"
#import "ScrollListView.h"

static NSString *const ReuseIdentifier = @"CELL";

@interface ScrollListViewController () <ScrollListViewDelegate, ScrollListViewDataSource>

@property NSArray *data;

@end

@implementation ScrollListViewController
#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 20.0f, self.view.frame.size.width, self.view.frame.size.height - 20.0f);
    
    ScrollListView *scrollListView = [[ScrollListView alloc] initWithFrame:frame];
    scrollListView.scrollPages = 20;
    scrollListView.delegate = self;
    scrollListView.dataSource = self;
    
    [self.view addSubview:scrollListView];
    
    scrollListView.currentPage = 1;
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        
        [data addObject:@[@{Text:[NSString stringWithFormat:@"TEST1 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST2 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST3 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST4 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST5 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST6 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST7 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST8 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST9 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST10 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST11 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST12 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST13 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST14 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST15 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST16 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST17 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST18 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST19 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST20 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST21 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST22 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST23 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST24 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST25 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST26 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST27 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST28 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST29 (%d)", i]},
                          @{Text:[NSString stringWithFormat:@"TEST30 (%d)", i]}]];
        
    }
    self.data = data;
    
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ScrollListViewDataSource
- (NSArray<NSDictionary *> *)scrollListView:(ScrollListView *)ScrollListView cellForRowShowDataAtCurrentPage:(NSUInteger)currentPage {
    NSLog(@"%s currentPage=%ld", __FUNCTION__, currentPage);
    return self.data[currentPage];
}

#pragma mark -
#pragma mark ScrollListViewDelegate
- (void)scrollListView:(ScrollListView *)ScrollListView didSelectListRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __FUNCTION__);
    
}

@end
