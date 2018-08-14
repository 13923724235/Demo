//
//  SortView.h
//  demo
//
//  Created by addcn on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortView : UIView

@property (nonatomic, copy) void(^sendUploadDataBlock)(NSMutableDictionary * dic); //回传选中数据

/**
 初始化
 @param frame 位置大小
 @param array 列表数据
 */
- (instancetype)initWithFrame:(CGRect)frame
                 withListData:(NSMutableArray *)array;

@end
