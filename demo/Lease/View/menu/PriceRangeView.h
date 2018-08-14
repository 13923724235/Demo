//
//  PriceRangeView.h
//  demo
//
//  Created by addcn on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceRangeView : UIView

@property (nonatomic, strong) UILabel * customLabel; //自定义文本

@property (nonatomic, strong) UIButton * determineBtn; //确定按钮

@property (nonatomic, strong) UITextField * minimumPriceField; //最小价格

@property (nonatomic, strong) UITextField * maximumPriceField; //最大价格

@property (nonatomic, strong) UILabel * transverselineLanbel; //横线

@property (nonatomic, strong) UILabel * yuanLabel; //元单位

@end
