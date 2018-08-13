//
//  RegionModel.h
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionModel : NSObject<YYModel>

@property(nonatomic,copy)NSString * titleName; //区域标题

@property(nonatomic,copy)NSString * number; //对应编号

@property(nonatomic,copy)NSString * isSelect; //是否选中

@property(nonatomic,strong)NSMutableArray * secondArray; //二级菜单数据


@end
