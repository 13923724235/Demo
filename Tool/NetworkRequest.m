//
//  NetworkRequest.m
//  demo
//
//  Created by addcn on 2018/8/10.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "NetworkRequest.h"

// 请求方式
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypeUpLoad,
    RequestTypeDownload
};

@implementation NetworkRequest

#pragma mark GET Network Request
+(void)getRequestUrlStr:(NSString *)urlStr success:(successBlock)success failure:(failureBlock)failure
{
    [[self alloc] requestWithUrl:urlStr withDic:nil requestType:RequestTypeGet isCache:NO cacheKey:nil imageKey:nil withData:nil upLoadProgress:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSString *errorInfo) {
        failure(@"请求失败");
    }];
}

#pragma mark POST Network Request
+ (void)postRequestUrlStr:(NSString *)urlStr withDic:(NSDictionary *)parameters success:(successBlock )success failure:(failureBlock)failure
{
    [[self alloc] requestWithUrl:urlStr withDic:parameters requestType:RequestTypePost isCache:NO cacheKey:nil imageKey:nil withData:nil upLoadProgress:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSString *errorInfo) {
        failure(@"请求失败");
    }];
    
}
#pragma mark -- Processing Network
-(void)requestWithUrl:(NSString *)url withDic:(NSDictionary *)parameters requestType:(RequestType)requestType  isCache:(BOOL)isCache  cacheKey:(NSString *)cacheKey imageKey:(NSString *)attach withData:(NSData *)data upLoadProgress:(loadProgress)loadProgress success:(successBlock)success failure:(failureBlock)failure
{
    
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    //返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //get请求
    if (requestType == RequestTypeGet)
    {
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(@"请求失败");
            
        }];
    }
    else if (requestType == RequestTypePost)  //post 请求
    {
        [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

          success(responseObject);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

          failure(@"请求失败");

        }];
    }
}

#pragma mark URL Splicing
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

+ (NSString *) modelDataIncomingDictionary:(UploadParametersModel *)model withPage:(NSInteger)page
{
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
    
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"p"];
    
     NSString * SelectRegion = [[NSUserDefaults standardUserDefaults]objectForKey:@"FirstListSelect"];
    
    NSString *keywoeds = [[self alloc] urlEncode:model.keywords stringEncoding:NSUTF8StringEncoding];
    
    if (model.keywords.length > 0)
    {
        [dic setObject:keywoeds forKey:@"keywords"];
      
    }
    
    if ([SelectRegion isEqualToString:@"區域"])
    {
       
        [dic setObject:model.kind forKey:@"kind"];
        [dic setObject:model.regionid forKey:@"regionid"];
        [dic setObject:model.price forKey:@"price"];
        [dic setObject:model.sectionid forKey:@"sectionid"];
        [dic setObject:@"1" forKey:@"searchtype"];
    }
    else if([SelectRegion isEqualToString:@"捷運"])
    {
        [dic setObject:model.subway_id forKey:@"subway_id"];
        [dic setObject:model.subway_line forKey:@"subway_line"];
        [dic setObject:model.price forKey:@"price"];
        [dic setObject:model.sectionid forKey:@"sectionid"];
        [dic setObject:@"2" forKey:@"searchtype"];
    }
    else if([SelectRegion isEqualToString:@"附近"])
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
    
    if (![model.minprice isEqualToString:@"默认"])
    {
        [dic setObject:model.minprice forKey:@"minprice"];
        
    }
    
    if (![model.maxprice isEqualToString:@"默认"])
    {
        [dic setObject:model.maxprice forKey:@"maxprice"];
    }
    
    
   return  [self spliceRequestUrl:dic];
}

//字符串转义
-(NSString*)urlEncode:(NSString *)originalString
       stringEncoding:(NSStringEncoding)stringEncoding{
    if(originalString==nil || [originalString isEqualToString:@""])
    {
        return @"";
    }
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    NSInteger len = [escapeChars count];
    
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    NSString *outStr = [NSString stringWithString:temp];
    return outStr;
}


@end
