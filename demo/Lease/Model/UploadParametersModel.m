//
//  UploadParametersModel.m
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "UploadParametersModel.h"


@implementation UploadParametersModel


-(instancetype)init
{
    if (self == [super init])
    {
        //默认值
        self.regionid = @"0";
        self.sectionid = @"0";
        self.subway_id = @"0";
        self.subway_line = @"0";
        self.kind = @"0";
        self.price = @"0";
        self.metter = @"0";
        self.keywords = @"";
        self.sort = @"90";
        self.minprice = @"";
        self.maxprice = @"";
        self.page = @"1";
        self.uploadType = RequestReginType;
    }
    
    return self;
}

+ (NSString *)incomingDataModel:(UploadParametersModel *)model
{
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
    
    [dic setObject:model.page forKey:@"p"];
    
    NSString * keywoeds = [NSString urlEncode:model.keywords stringEncoding:NSUTF8StringEncoding];
    
    if (model.keywords.length > 0)
    {
        [dic setObject:keywoeds forKey:@"keywords"];
        
    }
    
    if (model.uploadType == RequestReginType)
    {
        [dic setObject:model.kind forKey:@"kind"];
        [dic setObject:model.regionid forKey:@"regionid"];
        [dic setObject:model.price forKey:@"price"];
        [dic setObject:model.sectionid forKey:@"sectionid"];
        [dic setObject:@"1" forKey:@"searchtype"];
    }
    else if (model.uploadType == RequestJieYunType)
    {
        [dic setObject:model.subway_id forKey:@"subway_id"];
        [dic setObject:model.subway_line forKey:@"subway_line"];
        [dic setObject:model.price forKey:@"price"];
        [dic setObject:model.sectionid forKey:@"sectionid"];
        [dic setObject:@"2" forKey:@"searchtype"];
    }
    else if (model.uploadType == RequestNearbyType)
    {
        AppDelegate * appdelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [dic setObject:model.price forKey:@"price"];
        [dic setObject:model.kind forKey:@"kind"];
        [dic setObject:appdelegate.strlongitude forKey:@"lng"];
        [dic setObject:appdelegate.strlatitude forKey:@"lat"];
        [dic setObject:model.metter forKey:@"meter"];
    }
    
    if (![model.sort isEqualToString:@"0"])
    {
        if ([model.sort isEqualToString:@"32"])//刊登优先
        {
            [dic setObject:model.sort forKey:@"o"];
            [dic setObject:@"desc" forKey:@"orderType"];
            [dic setObject:@"posttime" forKey:@"orderField"];
        }
        else if ([model.sort isEqualToString:@"11"])//价格低到高
        {
            [dic setObject:model.sort forKey:@"o"];
            [dic setObject:@"asc" forKey:@"orderType"];
            [dic setObject:@"price" forKey:@"orderField"];
        }
        else if ([model.sort isEqualToString:@"12"])//价格高到低
        {
            [dic setObject:model.sort forKey:@"o"];
            [dic setObject:@"desc" forKey:@"orderType"];
            [dic setObject:@"price" forKey:@"orderField"];
        }
        else if ([model.sort isEqualToString:@"21"])//坪数小到大
        {
            [dic setObject:model.sort forKey:@"o"];
            [dic setObject:@"asc" forKey:@"orderType"];
            [dic setObject:@"area" forKey:@"orderField"];
        }
        else if ([model.sort isEqualToString:@"22"])//坪数大到小
        {
            [dic setObject:model.sort forKey:@"o"];
            [dic setObject:@"desc" forKey:@"orderType"];
            [dic setObject:@"area" forKey:@"orderField"];
        }
    }
    
    if (model.minprice.length > 0)
    {
        [dic setObject:model.minprice forKey:@"minprice"];
        
    }
    
    if (model.maxprice.length > 0)
    {
        [dic setObject:model.maxprice forKey:@"maxprice"];
    }
    
    
    return [self spliceRequestUrl:dic];
}

/**
 *  拼接url
 *  @param dic 传入的字典
 */
+ (NSString *)spliceRequestUrl:(NSMutableDictionary *)dic
{
    NSMutableString * url = [[NSMutableString alloc] init];
    
    [url appendString:HEADERREQUESTSTR];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString * splicestr =[NSString stringWithFormat:@"&%@=%@",key,obj];
        
        [url appendString:splicestr];
        
    }];
    
    return url;
}

@end
