//
//  MenuView.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

/**
 隐藏视图
 */
- (void)transparentClick;

/**
 初始化
 @param frame 位置大小
 @param array 标题数据
 */
- (instancetype)initWithFrame:(CGRect)frame withMenuTile:(NSArray *)array withFaterView:(UIView *)faterview;

/**
 初始化
 @param defArray 区域菜单标题数据
 @param reginAllArray 区域所有列表数据
 @param typeArray 类型列表数据
 @param rentArray 租房列表数据
 */
- (void)getrRegionRawDataWithDefault:(NSMutableArray *)defArray withaAllRegionDataMenu:(NSMutableArray *)reginAllArray withTypeRawData:(NSMutableArray *)typeArray withRentRewData:(NSMutableArray *)rentArray;


@end
