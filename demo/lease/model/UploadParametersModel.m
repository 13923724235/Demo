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
        self.sort = @"0";
        self.minprice = @"默认";
        self.maxprice = @"默认";
    }
    
    return self;
}

@end
