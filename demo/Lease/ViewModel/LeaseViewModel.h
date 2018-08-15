//
//  LeaseViewMoel.h
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, RequsetType) {
    ListRequest,
    Other //扩充 备用
};

typedef void (^successListDataBlock)(NSMutableDictionary *dic);
typedef void (^failureDataBlock)(NSString *error);

@interface LeaseViewModel : NSObject

@property (nonatomic, assign) RequsetType requestType;
@property (nonatomic, copy) successListDataBlock successBlock;
@property (nonatomic, copy) failureDataBlock failureBlock;

/**
 *  网络数据
 *  @param type  请求类型
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 */
- (void)setBlockWithRequestType:(RequsetType) type
               withSuccessBlock:(successListDataBlock) successBlock
               withFailureBlock:(failureDataBlock) failureBlock;

/**
 *  获取租房列表
 *  @param model  请求数据模型
 */
- (void)getLeaseListDataWithModel:(UploadParametersModel *)model;

@end
