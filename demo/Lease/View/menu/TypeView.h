//
//  TypeView.h
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeView : UIView

@property (nonatomic, copy) void(^sendTitleBlock)(NSString * name); //赋值名称

@property (nonatomic, copy) void(^sendUploadDataBlock)(NSMutableDictionary * dic); //回传选中数据
/**
 初始化
 @param frame 位置大小
 @param array 列表数据
 */
- (instancetype)initWithFrame:(CGRect)frame
                 withListData:(NSMutableArray *)array;

/**
 * 视图隐藏
 */
- (void)currentViewIsHidden:(BOOL)isHiden;

@end
