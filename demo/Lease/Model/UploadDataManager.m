//
//  UploadDataManager.m
//  demo
//
//  Created by addcn on 2018/8/13.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "UploadDataManager.h"


@implementation UploadDataManager


#pragma mark 处理区域数据
+ (UploadParametersModel *)uploadRegionDataWithModel:(UploadParametersModel *)model
                                             WithDic:(NSMutableDictionary *)dic
{
    
    NSString * type = dic[@"type"];
    
    if ([type isEqualToString:UNLIMITEDNAME])
    {
        model.regionid = @"0";
        model.sectionid = @"0";
        model.subway_line = @"0";
        model.subway_id = @"0";
        model.metter = @"0";
        model.uploadType = RequestUploadTypeRegion;
    }
    else if ([type isEqualToString:DEFAULTREGINNAME])//区域
    {
        RegionModel * reModel = dic[@"model"]; //县市id
        
        if (reModel)
        {
            model.regionid = reModel.number;
        }
        
        RegionModel * secondModel = dic[@"secondModel"];//乡镇id
        
        if (secondModel)
        {
            model.sectionid = secondModel.number;
        }
        
        model.subway_line = @"0";
        model.subway_id = @"0";
        model.metter = @"0";
        model.uploadType = RequestUploadTypeRegion;
    }
    else if ([type isEqualToString:JIEYUNNAME])//捷运
    {
        RegionModel * reModel = dic[@"model"]; //捷运id
        
        if (reModel)
        {
            model.subway_line = reModel.number;
        }
        
        RegionModel * secondModel = dic[@"secondModel"];//具体车站id
        
        if (secondModel)
        {
            model.subway_id = secondModel.number;
        }
        
        model.regionid = @"0";
        model.sectionid = @"0";
        model.metter = @"0";
        model.uploadType = RequestUploadTypeJieYun;
    }
    else if ([type isEqualToString:NEARBYMNAME])//附近
    {
        RegionModel * secondModel = dic[@"secondModel"];//具体车站id
        
        if (secondModel)
        {
            model.metter = secondModel.number;
        }
        
        model.regionid = @"0";
        model.sectionid = @"0";
        model.subway_line = @"0";
        model.subway_id = @"0";
        model.uploadType = RequestUploadTypeNearby;
    }
    
   
    return model;
    
}
#pragma mark 处理类型数据
+ (UploadParametersModel *)uploadTypeDataWithModel:(UploadParametersModel *)model
                                           WithDic:(NSMutableDictionary *)dic
{
    RegionModel * reModel = dic[@"model"];
    
    if (reModel)
    {
        model.kind = reModel.number;
    }
    
    return model;
}

#pragma mark 处理租金数据
+ (UploadParametersModel *)uploadRentDataWithModel:(UploadParametersModel *)model
                                           WithDic:(NSMutableDictionary *)dic
{
    RegionModel * reModel = dic[@"model"];
    
    if (reModel)
    {
        model.price = reModel.number;
    }
    else
    {
        NSString * min = dic[@"Min"];
        NSString * max = dic[@"Max"];
        
        if (min)
        {
            model.minprice = min;
        }
        
        if (max)
        {
            model.maxprice = max;
        }
        
        model.price =@"99";
    }
    
    return  model;
}

#pragma mark 处理排序数据
+ (UploadParametersModel *)uploadSortDataWithModel:(UploadParametersModel *)model
                                           WithDic:(NSMutableDictionary *)dic
{
    RegionModel * reModel = dic[@"model"];
    
    if (reModel)
    {
        model.sort = reModel.number;
    }
    
    return model;
}

@end
