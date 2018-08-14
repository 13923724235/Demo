//
//  searchView.h
//  demo
//
//  Created by addcn on 2018/8/6.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView<UITextFieldDelegate>

//背景View
@property (nonatomic, strong) UIView *bgView;
//搜索图标
@property (nonatomic, strong) UIImageView *searchIcon;
//搜索框
@property (nonatomic, strong) UITextField * seaechtextfield;



@end
