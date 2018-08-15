//
//  MyDIYRefresh.h
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RefreshType) {
    RefreshTypeHeader, //只有下拉刷新
    RefreshTypeFooter, //只有上拉刷新
    RefreshTypeHeaderWithFooter, //有上下拉刷新
    RefreshTypeDIYHeaderWithFooter, //自定义上下拉刷新
};;

@interface MyDIYRefresh : NSObject

/**
 上下拉刷新调用方式
 
 @param scrollView scrollView
 @param refreshType 刷新类型
 @param headerRefresh 下拉回调
 @param footerRefresh 上拉回调
 */
- (void)refreshView:(UIScrollView *)scrollView
       refreshType:(RefreshType)refreshType
       headerRefreshBlock:(void(^)(void))headerRefresh
       footerRefreshBlock:(void(^)(void))footerRefresh;


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
