//
//  LeaseViewMoel.h
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, RequsetType) {
    RequsetTypeRequest,
    RequsetTypeOther //扩充 备用
};

typedef void (^successListDataBlock)(NSMutableDictionary *dic);
typedef void (^failureDataBlock)(NSString *error);

@interface LeaseViewModel : NSObject


/**
 *  网络数据
 *  @param type  请求类型
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param model 请求数据模型
 */
- (void)setBlockWithRequestType:(RequsetType) type
               withSuccessBlock:(successListDataBlock) successBlock
               withFailureBlock:(failureDataBlock) failureBlock
                withLeaseMoldel:(UploadParametersModel *)model;


@end
