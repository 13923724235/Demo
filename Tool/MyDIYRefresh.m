//
//  MyDIYRefresh.m
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MyDIYRefresh.h"

static NSString * const scrollKey= @"scrollKey";
static MyDIYRefresh *refresh = nil;

@implementation MyDIYRefresh

+(instancetype)shareRefresh
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        refresh = [[self alloc] init];
    });
    return refresh;
}

- (void)refreshView:(UIScrollView *)scrollView refreshType:(RefreshType)refreshType headerRefreshBlock:(headerRefreshBlock)headerBlock footerRefreshBlock:(footerRefreshBlock)footerBlock
{
    objc_setAssociatedObject(self, &scrollKey, scrollView, OBJC_ASSOCIATION_RETAIN);
    _headerBlock = headerBlock;
    _footerBlock = footerBlock;
    
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
-(void)headerRefreshMethod
{
    [self scrollView].mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.headerBlock)
        {
            self.headerBlock();
        }
    }];
}
//默认加载更多
-(void)footerRefreshMethod
{
    [self scrollView].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.footerBlock)
        {
            self.footerBlock();
        }
    }];
}

//自定义下拉刷新
-(void)diyHeaderRefreshMethod
{
    [self scrollView].mj_header =[MyDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

-(void)loadNewData
{
    if (self.headerBlock)
    {
        self.headerBlock();
    }
}

-(void)beginRefreshing
{
    [[self scrollView].mj_header beginRefreshing];
}

-(void)headerEndRefreshing
{
    [[self scrollView].mj_header endRefreshing];
}

-(void)footerEndRefreshing
{
    [[self scrollView].mj_footer endRefreshing];
}

-(void)footerEndRefreshingWithNoMoreData
{
    [[self scrollView].mj_footer endRefreshingWithNoMoreData];
}

-(UIScrollView *)scrollView
{
    return (UIScrollView *)objc_getAssociatedObject(self, &scrollKey);
}

@end
