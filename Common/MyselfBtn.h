//
//  MyselfBtn.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyselfBtn;

typedef void(^menuTitleButtonBlock)(MyselfBtn *btn);

@interface MyselfBtn : UIButton

//按钮点击事件回传
@property (nonatomic, copy) menuTitleButtonBlock block ;

/** 标题 */
@property (nonatomic,strong) UILabel *btnTitle;
/** 箭头 */
@property (nonatomic,strong) UIImageView *imgArrow;

/**
 *  newCreateButton 实例化
 */
+ (instancetype )newCreateButton;

@end
