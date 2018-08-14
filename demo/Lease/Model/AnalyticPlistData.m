//
//  AnalyticPlistData.m
//  demo
//
//  Created by addcn on 2018/8/10.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "AnalyticPlistData.h"
#import "RegionModel.h"
static AnalyticPlistData *analyShareManager;

@implementation AnalyticPlistData

#pragma mark --单例
+ (instancetype)shareInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        analyShareManager = [[AnalyticPlistData alloc] init];
        
     
    });
    return analyShareManager;
    
}
#pragma mark --获取文件位置
-(NSMutableDictionary *)getPlistFile
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"region" ofType:@"plist"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    return dic;
}

#pragma mark --获取plist文件区域数据
- (NSMutableArray *)getReginPlistData
{
    NSMutableDictionary * dic = [self getPlistFile];
    
    NSDictionary * regiondic =dic[@"region"]; //区域
    NSDictionary * regionSeconddic = dic[@"region_section"];//区域二级菜单
    
    NSMutableArray * findArray = [[NSMutableArray alloc] init];
    
    //找出区域数据
    [regiondic enumerateKeysAndObjectsUsingBlock:^(NSString * firstkey, NSString * firstTitle, BOOL * _Nonnull stop) {
        
        if (![firstkey isEqualToString:@"sort"])
        {
            
            NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
            
            [dic setObject:firstkey forKey:@"Number"];
            [dic setObject:firstTitle forKey:@"TitleName"];
            [dic setObject:@"0" forKey:@"IsSelect"];
            
            RegionModel * remodel =[RegionModel yy_modelWithDictionary:dic];
            
         
            if ([firstkey isEqualToString:@"0"])
            {
                remodel.isSelect = @"1";
            }
    

            [regionSeconddic enumerateKeysAndObjectsUsingBlock:^(NSString * secondkey, NSMutableDictionary * seconddic, BOOL * _Nonnull stop) {
                
                NSMutableArray * SecondregionSortArray = seconddic[@"sort"];
                
                if ([firstkey isEqualToString:secondkey])
                {
                    
                    [seconddic enumerateKeysAndObjectsUsingBlock:^(NSString * threekey, NSString * threevalue, BOOL * _Nonnull stop) {
                        
                        NSMutableDictionary * threedic =[[NSMutableDictionary alloc] init];
                        [threedic setObject:threekey forKey:@"Number"];
                        [threedic setObject:threevalue forKey:@"TitleName"];
                        [threedic setObject:@"0" forKey:@"IsSelect"];
                        
                        RegionModel * threeremodel =[RegionModel yy_modelWithDictionary:threedic];
                        
                        [remodel.secondArray addObject:threeremodel];
                        
                    }];
                    
                    remodel.secondArray = [self regionSortData:remodel.secondArray withSortArray:SecondregionSortArray];
                    
                    
                }
                
            }];
            
            [findArray addObject:remodel];
        }
        
        
    }];
    
    NSMutableArray * regionSortArray = regiondic[@"sort"];
    
    findArray = [self regionSortData:findArray withSortArray:regionSortArray];
    
    return findArray;
}

#pragma mark -- 获取plistjieyun信息
- (NSMutableArray *)getJieYunPlistData
{
    
    NSMutableDictionary * dic = [self getPlistFile];
    
     NSDictionary * jueyundic = dic[@"jieyun"];//捷運
     NSDictionary * jieyunSeconddic = dic[@"jieyun_section"];//捷运二级菜单
    
    NSMutableArray * findArray = [[NSMutableArray alloc] init];
    
    //找出捷运数据
    [jueyundic enumerateKeysAndObjectsUsingBlock:^(NSString * firstkey, NSString * firstTitle, BOOL * _Nonnull stop) {
        
        if (![firstkey isEqualToString:@"sort"])
        {
            NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
            
            [dic setObject:firstkey forKey:@"Number"];
            [dic setObject:firstTitle forKey:@"TitleName"];
            [dic setObject:@"0" forKey:@"IsSelect"];
            RegionModel * remodel =[RegionModel yy_modelWithDictionary:dic];
            
            [jieyunSeconddic enumerateKeysAndObjectsUsingBlock:^(NSString * secondkey, NSMutableDictionary * seconddic, BOOL * _Nonnull stop) {
                
                NSMutableArray * SecondregionSortArray = seconddic[@"sort"];
                
                if ([firstkey isEqualToString:secondkey])
                {
                    [seconddic enumerateKeysAndObjectsUsingBlock:^(NSString * threekey, NSString * threevalue, BOOL * _Nonnull stop) {
                        
                        NSMutableDictionary * threedic =[[NSMutableDictionary alloc] init];
                        [threedic setObject:threekey forKey:@"Number"];
                        [threedic setObject:threevalue forKey:@"TitleName"];
                        [threedic setObject:@"0" forKey:@"IsSelect"];
                        
                        RegionModel * threeremodel =[RegionModel yy_modelWithDictionary:threedic];
                        
                        [remodel.secondArray addObject:threeremodel];
                        
                    }];
                    
                    remodel.secondArray =  [self regionSortData:remodel.secondArray withSortArray:SecondregionSortArray];
                }
                
            }];
            
            [findArray addObject:remodel];
            
        }
        
    }];
    
    NSMutableArray * jueyun = jueyundic[@"sort"];
    
    findArray = [self regionSortData:findArray withSortArray:jueyun];
    
    return findArray;
}

#pragma mark -- 获取plist附近信息
- (NSMutableArray *)getNearByPlistData
{
    NSMutableDictionary * dic = [self getPlistFile];
    
    NSDictionary * nearBydic = dic[@"nearBy_limit"]; //附近
    
    NSMutableArray * findArray = [[NSMutableArray alloc] init];
    
    [nearBydic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
        
        [dic setObject:key forKey:@"Number"];
        [dic setObject:obj forKey:@"TitleName"];
        [dic setObject:@"0" forKey:@"IsSelect"];
        RegionModel * remodel =[RegionModel yy_modelWithDictionary:dic];
        
        [findArray addObject:remodel];
        
    }];
    
    NSMutableArray * nearby = nearBydic[@"sort"];
    
    findArray = [self regionSortData:findArray withSortArray:nearby];
    
    return findArray;
}

#pragma mark -- 获取plist类型信息
- (NSMutableArray *)getTpyePlistData
{
    NSMutableDictionary * dic = [self getPlistFile];
    
    NSDictionary * regiondic =dic[@"kind_rent"]; //类型
    
    NSMutableArray * findArray = [[NSMutableArray alloc] init];
    
    [regiondic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
        
        [dic setObject:key forKey:@"Number"];
        [dic setObject:obj forKey:@"TitleName"];
        [dic setObject:@"0" forKey:@"IsSelect"];
        RegionModel * remodel =[RegionModel yy_modelWithDictionary:dic];
        

        if ([key isEqualToString:@"0"])
        {
            remodel.isSelect = @"1";

        }
        else
        {
            remodel.isSelect = @"0";
        }
        
        
        [findArray addObject:remodel];
        
    }];
    
    NSMutableArray * sorttype = regiondic[@"sort"];
    
    findArray = [self regionSortData:findArray withSortArray:sorttype];
    
    return findArray;
}

#pragma mark -- 获取plist租金信息
- (NSMutableArray *)getRentPricePlistData
{
    NSMutableDictionary * dic = [self getPlistFile];
    
    NSDictionary * rentPricedic =dic[@"rentPrice"]; //租金
    
    NSMutableArray * findArray = [[NSMutableArray alloc] init];
    
    [rentPricedic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
        
        [dic setObject:key forKey:@"Number"];
        [dic setObject:obj forKey:@"TitleName"];
        [dic setObject:@"0" forKey:@"IsSelect"];
        RegionModel * remodel =[RegionModel yy_modelWithDictionary:dic];
        
        NSData * data =  [[NSUserDefaults standardUserDefaults]objectForKey:@"RentListSelect"];
        
        if (data == nil)
        {
            if ([key isEqualToString:@"0"])
            {
                remodel.isSelect = @"1";
            }
        }
        else
        {
            RegionModel * totalmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            if ([totalmodel.number isEqualToString:remodel.number])
            {
                remodel.isSelect = @"1";
            }
        }
        
        [findArray addObject:remodel];
        
    }];
    
    NSMutableArray * nearby = rentPricedic[@"sort"];
    
    findArray = [self regionSortData:findArray withSortArray:nearby];
    
    return findArray;
}

#pragma mark -- 获取plist排序信息
- (NSMutableArray *)getSortPlistDataWithSelectId:(NSString *)selectId
{
    NSMutableDictionary * dic = [self getPlistFile];
    
    NSDictionary * sortdic =dic[@"sort_kind_sale"]; //排序类型
    
    NSMutableArray * findArray = [[NSMutableArray alloc] init];
    
    [sortdic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
        
        [dic setObject:key forKey:@"Number"];
        [dic setObject:obj forKey:@"TitleName"];
        [dic setObject:@"0" forKey:@"IsSelect"];
        RegionModel * remodel =[RegionModel yy_modelWithDictionary:dic];
        

        if ([key isEqualToString:selectId])
        {
            remodel.isSelect = @"1";
        }
        else
        {

            remodel.isSelect = @"0";
            
        }
        
        [findArray addObject:remodel];
        
    }];
    
    NSMutableArray * sorttype = sortdic[@"sort"];
    
    findArray = [self regionSortData:findArray withSortArray:sorttype];
    
    return findArray;
}

//排序
-(NSMutableArray *)regionSortData:(NSMutableArray *)array withSortArray:(NSMutableArray *)sortarray
{
    NSMutableArray * NewArray =[[NSMutableArray alloc] init];
    
    for (int i = 0; i < sortarray.count;i++)
    {
        NSString * str = sortarray[i];
        
        for ( RegionModel * model in array)
        {
            NSString *number = model.number;
            
            if ([str isEqualToString:number])
            {
                [NewArray addObject:model];
                break;
            }
        }
        
    }
    
    return NewArray;
}


@end
