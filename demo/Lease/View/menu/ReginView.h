//
//  ReginView.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionModel.h"

// 选中类型
typedef NS_ENUM(NSInteger, ReginListSelectTpye) {
    ReginListSelectTpyeRegin = 0,
    ReginListSelectTpyeJieYun = 1,
    ReginListSelectTpyeNearby = 2,
    
};


@interface ReginView : UIView

@property (nonatomic, copy) void(^sendDataBlock)(void); //消失控件

@property (nonatomic, copy) void(^sendTitleBlock)(NSString * name); //赋值名称

@property (nonatomic, copy) void(^sendUploadDataBlock)(NSMutableDictionary * dic); //回传选中数据

@property (nonatomic, assign) ReginListSelectTpye selecType;

/**
 初始化
 @param frame 位置大小
 @param titleArray 标题数据
 @param allReginArray 区域数据
 */
- (instancetype)initWithFrame:(CGRect)frame
                withTitleData:(NSMutableArray *)titleArray
            withReginListData:(NSMutableArray *)allReginArray;

/**
* 定位关闭移除附近数据
 */
- (void)removeNearbyData;

/**
 * 视图隐藏
 */
- (void)currentViewIsHidden:(BOOL)isHiden;

@end
