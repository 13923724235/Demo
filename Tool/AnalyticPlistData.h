//
//  AnalyticPlistData.h
//  demo
//
//  Created by addcn on 2018/8/10.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyticPlistData : NSObject

/**
 *  shareInstance 单例
 */
+ (instancetype)shareInstance;

/**
 *  获取plist区域信息
 */
- (NSMutableArray *)getReginPlistData;

/**
 * 获取plistjieyun信息
 */
- (NSMutableArray *)getJieYunPlistData;

/**
 * 获取plist附近信息
 */
- (NSMutableArray *)getNearByPlistData;

/**
 * 获取plist类型信息
 */
- (NSMutableArray *)getTpyePlistData;

/**
 * 获取plist类型信息
 */
- (NSMutableArray *)getRentPricePlistData;

/**
 * 获取plist排序信息
 */
- (NSMutableArray *)getSortPlistData;


@end
