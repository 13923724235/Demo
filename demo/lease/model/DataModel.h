//
//  DataModel.h
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject<YYModel>

@property(nonatomic,copy) NSString *address; //地址

@property(nonatomic,copy) NSString *area; //格局

@property(nonatomic,copy) NSString *title;//标题

@property(nonatomic,copy) NSString *price;//价格

@property(nonatomic,copy) NSString * photo_src; //封面

@property(nonatomic,copy) NSString * houseid; //房屋编号

@property(nonatomic,copy) NSString * is_mvip; // 2精选 1置顶 0普通

@property(nonatomic,copy) NSString * is_online; //是否在线

@end
