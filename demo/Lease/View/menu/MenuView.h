//
//  MenuView.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property (nonatomic, copy) void(^backRrginDataBlock)(NSMutableDictionary * dic); //回传区域数据

@property (nonatomic, copy) void(^backTypeDataBlock)(NSMutableDictionary * dic); //回传类型数据

@property (nonatomic, copy) void(^backRentDataBlock)(NSMutableDictionary * dic); //回传租金数据

/**
 隐藏视图
 */
- (void)transparentClick;

/**
 初始化
 @param frame 位置大小
 @param array 标题数据
 */
- (instancetype)initWithFrame:(CGRect)frame
                 withMenuTile:(NSArray *)array
                withFaterView:(UIView *)faterview;

/**
 初始化
 @param defArray 区域菜单标题数据
 @param reginAllArray 区域所有列表数据
 @param typeArray 类型列表数据
 @param rentArray 租房列表数据
 */
- (void)getrRegionRawDataWithDefaultArr:(NSMutableArray *)defArray
                          reginAllArray:(NSMutableArray *)reginAllArray
                              typeArray:(NSMutableArray *)typeArray
                              rentArray:(NSMutableArray *)rentArray;


@end
