//
//  Menulistcell.h
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionModel.h"
@interface Menulistcell : UITableViewCell

@property(nonatomic,strong)UILabel * titleLabel; //标题

@property(nonatomic,strong)UIView * line; //分割线

@property(nonatomic,strong)RegionModel * model; //数据

@property(nonatomic,strong)NSMutableDictionary * temoDic; //第一列数据

@end
