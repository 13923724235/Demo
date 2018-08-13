//
//  TypeView.h
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeView : UIView

@property(nonatomic,copy)void(^sendTitleBlock)(NSString * name); //赋值名称
/**
 初始化
 @param frame 位置大小
 @param array 列表数据
 */
- (instancetype)initWithFrame:(CGRect)frame withListData:(NSMutableArray *)array;



@end
