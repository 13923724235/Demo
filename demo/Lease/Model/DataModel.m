//
//  DataModel.m
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

// 直接映射 字典中的key 值 到 Book 模型中的属性
// 映射后,就不用创建 第二个类 Author ,也可以用点语法 访问 作者姓名 和 作者生日
// 不用映射,需要创建第二个类 Author ,并且在 Author 中添加对应的 key
+ (NSDictionary *)modelCustomPropertyMapper{
    
    return @{@"address" : @"address",  // 层级之间用 '.' 隔开
             @"area" : @"area",
             @"title" : @"title",
             @"price" :@"price",
             @"photo_src" :@"photo_src",
             @"houseid" :@"houseid",
             @"is_mvip" :@"is_mvip",
             @"is_online" :@"is_online",
             };
}

// 白名单
// 如果实现了该方法，则处理过程中不会处理该列表外的属性。
+ (NSArray *)modelPropertyWhitelist {
    
    return @[@"address",@"area",@"title",@"price",@"photo_src",@"houseid",@"is_mvip",@"is_online"];  // 不同的属性之间用 ',' 隔开
}

//重写归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    return [self yy_modelInitWithCoder:aDecoder];
}


@end
