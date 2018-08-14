//
//  NetworkRequest.h
//  demo
//
//  Created by addcn on 2018/8/10.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadParametersModel.h"
typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSString *errorInfo);
typedef void (^loadProgress)(float progress);

@interface NetworkRequest : NSObject

/**
 *  单利实例化
 */
+ (instancetype)shareInstance;


/**
 *  Get请求
 *
 *  @param urlStr  url
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)getRequestUrlStr:(NSString *)urlStr
                 success:(successBlock)success
                 failure:(failureBlock)failure;

/**
 *  Post请求
 *
 *  @param urlStr     url
 *  @param parameters post参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (void)postRequestUrlStr:(NSString *)urlStr
                  withDic:(NSDictionary *)parameters
                  success:(successBlock)success
                  failure:(failureBlock)failure;


@end
