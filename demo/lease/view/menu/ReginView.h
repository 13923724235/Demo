//
//  ReginView.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionModel.h"
@interface ReginView : UIView

@property(nonatomic,copy)void(^sendDataBlock)(void); //消失控件

@property(nonatomic,copy)void(^sendTitleBlock)(NSString * name); //赋值名称


/**
 初始化
 @param frame 位置大小
 @param titleArray 标题数据
 @param allReginArray 区域数据

 */
- (instancetype)initWithFrame:(CGRect)frame withTitleData:(NSMutableArray *)titleArray withReginListData:(NSMutableArray *)allReginArray;

@end
