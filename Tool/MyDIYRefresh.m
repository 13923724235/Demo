//
//  MyDIYRefresh.m
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MyDIYRefresh.h"

static NSString * const scrollKey= @"scrollKey";
static NSString * const headerBlockKey= @"headerBlockKey";
static NSString * const footerBlockKey= @"footerBlockKey";
static MyDIYRefresh *refresh = nil;

@implementation MyDIYRefresh

- (void)refreshView:(UIScrollView *)scrollView
       refreshType:(RefreshType)refreshType
headerRefreshBlock:(void(^)(void))headerRefresh
footerRefreshBlock:(void(^)(void))footerRefresh
{
    objc_setAssociatedObject(self, &scrollKey, scrollView, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &headerBlockKey, headerRefresh, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &footerBlockKey, footerRefresh, OBJC_ASSOCIATION_COPY);
    
    switch (refreshType) {
            
        case RefreshTypeHeader:{ //只有下拉刷新
             [self headerRefreshMethod];
        }
            break;
        case RefreshTypeFooter:{ //只有上拉加载
            [self footerRefreshMethod];
        }
            break;
        case RefreshTypeHeaderWithFooter:{ //有上拉和下拉
             [self headerRefreshMethod];
             [self footerRefreshMethod];
        }
            break;
        case RefreshTypeDIYHeaderWithFooter:{ //自定上下拉
            [self diyHeaderRefreshMethod];
            [self footerRefreshMethod];
        }
            break;
        default:
            break;
    }
    
}
//默认拉下刷新
- (void)headerRefreshMethod
{
    void (^headerBlock)(void) = ^{};
    headerBlock = objc_getAssociatedObject(self, &headerBlockKey);
    [self scrollView].mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (headerBlock)
        {
            headerBlock();
        }
    }];
}
//默认加载更多
- (void)footerRefreshMethod
{
    void (^footerBlock)(void) = ^{};
    footerBlock = objc_getAssociatedObject(self, &footerBlockKey);
    [self scrollView].mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (footerBlock)
        {
            footerBlock();
        }
    }];
}

//自定义下拉刷新
- (void)diyHeaderRefreshMethod
{
    [self scrollView].mj_header =[MyDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

- (void)loadNewData
{
    void (^headerBlock)(void) = ^{};
    headerBlock = objc_getAssociatedObject(self, &headerBlockKey);
    
    if (headerBlock)
    {
        headerBlock();
    }
}

- (void)beginRefreshing
{
    [[self scrollView].mj_header beginRefreshing];
}

- (void)headerEndRefreshing
{
    [[self scrollView].mj_header endRefreshing];
}

- (void)footerEndRefreshing
{
    [[self scrollView].mj_footer endRefreshing];
}

- (void)footerEndRefreshingWithNoMoreData
{
    [[self scrollView].mj_footer endRefreshingWithNoMoreData];
}

- (UIScrollView *)scrollView
{
    return (UIScrollView *)objc_getAssociatedObject(self, &scrollKey);
}

@end
