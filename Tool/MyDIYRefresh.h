//
//  MyDIYRefresh.h
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RefreshType) {
    RefreshTypeHeader, //只有下拉刷新
    RefreshTypeFooter, //只有上拉刷新
    RefreshTypeHeaderWithFooter, //有上下拉刷新
    RefreshTypeDIYHeaderWithFooter, //自定义上下拉刷新
};;

typedef void (^headerRefreshBlock)(void);
typedef void (^footerRefreshBlock)(void);

@interface MyDIYRefresh : NSObject

@property (nonatomic, copy) headerRefreshBlock headerBlock;
@property (nonatomic, copy) footerRefreshBlock footerBlock;

/**
 *  单利实例化
 */
+ (instancetype)shareRefresh;

/**
 *  上下拉刷新调用方式
 *  @param scrollView  scrollView
 *  @param refreshType 刷新类型
 *  @param headerBlock 下拉回调
 *  @param footerBlock 上拉回调
 */
- (void)refreshView:(UIScrollView *)scrollView refreshType:(RefreshType)refreshType headerRefreshBlock:(headerRefreshBlock)headerBlock footerRefreshBlock:(footerRefreshBlock)footerBlock;


/**
 开始刷新
 */
- (void)beginRefreshing;

/**
 下拉结束刷新
 */
- (void)headerEndRefreshing;

/**
 上拉结束刷新
 */
- (void)footerEndRefreshing;

/**
 上拉结束刷新 没有更多数据
 */
- (void)footerEndRefreshingWithNoMoreData;

@end
