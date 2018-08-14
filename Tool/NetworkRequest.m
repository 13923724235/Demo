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

static NetworkRequest *requestManager;

@implementation NetworkRequest


+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        requestManager = [[NetworkRequest alloc] init];
        
    });
    return requestManager;
}

#pragma mark GET Network Request
- (void)getRequestUrlStr:(NSString *)urlStr
                 success:(successBlock)success
                 failure:(failureBlock)failure
{
    [self requestWithUrl:urlStr withDic:nil requestType:RequestTypeGet isCache:NO cacheKey:nil imageKey:nil withData:nil upLoadProgress:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSString *errorInfo) {
        failure(@"请求失败");
    }];
}

#pragma mark POST Network Request
- (void)postRequestUrlStr:(NSString *)urlStr
                  withDic:(NSDictionary *)parameters
                  success:(successBlock)success
                  failure:(failureBlock)failure
{
    [self requestWithUrl:urlStr withDic:parameters requestType:RequestTypePost isCache:NO cacheKey:nil imageKey:nil withData:nil upLoadProgress:nil success:^(id responseObject) {
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



@end
