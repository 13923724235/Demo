//
//  RentingCell.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
@interface RentingCell : UITableViewCell

@property (nonatomic, strong) UIImageView *photo; //封面

@property (nonatomic, strong) UIImageView *typePhoto; //类型

@property (nonatomic, strong) UIImageView *is_onlinePhoto; //是否在线

@property (nonatomic, strong) UILabel *titleLabel; //标题

@property (nonatomic, strong) UILabel *addressLabel; //地址

@property (nonatomic, strong) UILabel *arearessLabel; //格局

@property (nonatomic, strong) UILabel *priceLabel; //价格

@property (nonatomic, strong) UIView *line; //分割线

@property (nonatomic, strong) DataModel *model; //数据

@end
