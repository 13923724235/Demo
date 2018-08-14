//
//  UploadParametersModel.h
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

// 上传方式
typedef NS_ENUM(NSInteger, RequestUploadType) {
    RequestReginType = 0,
    RequestJieYunType = 1,
    RequestNearbyType = 2,
    
};


@interface UploadParametersModel : NSObject

//区域使用
@property (nonatomic, copy) NSString *regionid; //县市id

@property (nonatomic, copy) NSString *sectionid; //乡镇id

@property (nonatomic, copy) NSString *subway_id; //具体车站id

@property (nonatomic, copy) NSString *subway_line; //捷运id

@property (nonatomic, copy) NSString *sort; //排序

@property (nonatomic, copy) NSString *minprice; //最小价格

@property (nonatomic, copy) NSString *maxprice; //最大价格


//类型
@property (nonatomic, copy) NSString *kind; //类型

//租金
@property (nonatomic, copy) NSString *price; //价格

@property (nonatomic, copy) NSString *metter; //附近

@property (nonatomic, copy) NSString *keywords; //关键字

@property (nonatomic, copy) NSString *page; //页码

@property (nonatomic, assign) RequestUploadType uploadType; //数据上传类型
/**
 *  拼接数据
 *  @param model 传入的模型
 */
+ (NSString *)incomingDataModel:(UploadParametersModel *)model;



@end
