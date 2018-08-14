//
//  UploadDataManager.h
//  demo
//
//  Created by addcn on 2018/8/13.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadDataManager : NSObject



/**
 *  上传区域数据处理
 *  @param model 要处理的模型
 *  @param dic   要处理的字典
 */
+ (UploadParametersModel *)uploadRegionDataWithModel:(UploadParametersModel *)model
                                             WithDic:(NSMutableDictionary *)dic;

/**
 *  上传类型数据处理
 *  @param model 要处理的模型
 *  @param dic   要处理的字典
 */
+ (UploadParametersModel *)uploadTypeDataWithModel:(UploadParametersModel *)model
                                             WithDic:(NSMutableDictionary *)dic;

/**
 *  上传租金数据处理
 *  @param model 要处理的模型
 *  @param dic   要处理的字典
 */
+ (UploadParametersModel *)uploadRentDataWithModel:(UploadParametersModel *)model
                                           WithDic:(NSMutableDictionary *)dic;


/**
 *  上传排序数据处理
 *  @param model 要处理的模型
 *  @param dic   要处理的字典
 */
+ (UploadParametersModel *)uploadSortDataWithModel:(UploadParametersModel *)model
                                           WithDic:(NSMutableDictionary *)dic;

@end
