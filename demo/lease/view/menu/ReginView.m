//
//  ReginView.m
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "ReginView.h"
#import "RegionModel.h"
#import "Menulistcell.h"



@interface ReginView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * regionDefaultArray; //区域默认数据

@property(nonatomic,strong)NSMutableArray * regionAllDataArray; //区域数据

@property(nonatomic,strong)UITableView * FirstTbaleview; //第一个列表

@property(nonatomic,strong)UITableView * SecondTbaleview; //第二个列表

@property(nonatomic,strong)UITableView * ThreeTbaleview; //第三个列表

@end

@implementation ReginView

#pragma mark Lazy load

- (UITableView *)FirstTbaleview
{
    if (!_FirstTbaleview)
    {
        _FirstTbaleview =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _FirstTbaleview.dataSource = self;
        _FirstTbaleview.delegate  = self;
        _FirstTbaleview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _FirstTbaleview.backgroundColor =[UIColor whiteColor];
        _FirstTbaleview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
        _FirstTbaleview.hidden = YES;
    }
    
    return _FirstTbaleview;
}

- (UITableView *)SecondTbaleview
{
    if (!_SecondTbaleview)
    {
        _SecondTbaleview =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _SecondTbaleview.dataSource = self;
        _SecondTbaleview.delegate  = self;
        _SecondTbaleview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _SecondTbaleview.backgroundColor =[UIColor whiteColor];
        _SecondTbaleview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
        _SecondTbaleview.hidden = YES;
    }
    
    return _SecondTbaleview;
}

- (UITableView *)ThreeTbaleview
{
    if (!_ThreeTbaleview)
    {
        _ThreeTbaleview =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _ThreeTbaleview.dataSource = self;
        _ThreeTbaleview.delegate  = self;
        _ThreeTbaleview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ThreeTbaleview.backgroundColor =[UIColor whiteColor];
        _ThreeTbaleview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
         _ThreeTbaleview.hidden = YES;
    }
    
    return _ThreeTbaleview;
}

-(NSMutableArray *)regionDefaultArray
{
    if (!_regionDefaultArray)
    {
        _regionDefaultArray =[[NSMutableArray alloc] init];

    }

    return _regionDefaultArray;
}


-(NSMutableArray *)regionAllDataArray
{
    if (!_regionAllDataArray)
    {
        _regionAllDataArray =[[NSMutableArray alloc] init];
        
    }
    
    return _regionAllDataArray;
}


#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame withTitleData:(NSMutableArray *)titleArray withReginListData:(NSMutableArray *)allReginArray
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor jk_colorWithHexString:@"e7e7e7"];

        [self.regionDefaultArray removeAllObjects];
        [self.regionAllDataArray removeAllObjects];

        self.regionDefaultArray = titleArray;
        self.regionAllDataArray = allReginArray;

        [self creteUI];

    }

    return self;
}


-(void)creteUI
{
    [self addSubview:self.FirstTbaleview];
    [self addSubview:self.SecondTbaleview];
    [self addSubview:self.ThreeTbaleview];
    
       CGFloat clearance = 0.5;
        CGFloat TabWidth = SCREEN_WIDTH/2-clearance;
        
        self.FirstTbaleview.hidden = NO;
        self.SecondTbaleview.hidden =NO;
        self.ThreeTbaleview.hidden = YES;
        
        self.FirstTbaleview.frame = CGRectMake(0, 0, TabWidth, CGRectGetHeight(self.frame));
        self.SecondTbaleview.frame = CGRectMake(TabWidth+clearance, 0, TabWidth, CGRectGetHeight(self.frame));

}

#pragma  mark Tableview Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.FirstTbaleview)
    {
        return self.regionDefaultArray.count;
    }
    else if (tableView == self.SecondTbaleview)
    {
        for (int i = 0; i < self.regionDefaultArray.count; i++)
        {
            NSMutableDictionary * dic = self.regionDefaultArray[i];

            if (dic)
            {
                NSString * select = dic[@"Select"];

                if ([select isEqualToString:@"1"])//选中
                {
                    NSMutableArray * array = self.regionAllDataArray[i];

                    if (array)
                    {
                         return array.count;
                    }

                }

            }
        }

    }
    else if (tableView == self.ThreeTbaleview)
    {
        if (self.ThreeTbaleview.hidden == YES)
        {
            return  0;
        }
        else
        {
            for (int i = 0; i < self.regionDefaultArray.count; i++)
            {
                NSMutableDictionary * dic = self.regionDefaultArray[i];

                if (dic)
                {
                    NSString * select = dic[@"Select"];

                    if ([select isEqualToString:@"1"])//选中
                    {
                        NSMutableArray * array = self.regionAllDataArray[i];

                        if (array)
                        {
                            for (RegionModel * model in array)
                            {
                                if ([model.isSelect isEqualToString:@"1"])
                                {
                                    return model.secondArray.count;
                                }
                            }
                        }

                    }

                }
            }
        }

    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"Identifier";
    Menulistcell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[Menulistcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor whiteColor];
        
    }
    
    if (tableView == self.FirstTbaleview)
    {
        NSMutableDictionary * dic = self.regionDefaultArray[indexPath.section];
        
        cell.temoDic = dic;
        
    }
    else if(tableView == self.SecondTbaleview)
    {
        for(int i = 0; i < self.regionDefaultArray.count;i++)
        {
            NSMutableDictionary * dic = self.regionDefaultArray[i];
            NSString * select = dic[@"Select"];

            if ([select isEqualToString:@"1"])//选中
            {
               NSMutableArray * array = self.regionAllDataArray[i];
               RegionModel * newmodel = array[indexPath.section];
               cell.model = newmodel;
            }
            
        }
       
    }
    else if (tableView == self.ThreeTbaleview)
    {
        for (int i = 0; i < self.regionDefaultArray.count; i++)
        {
            NSMutableDictionary * dic = self.regionDefaultArray[i];

            if (dic)
            {
                NSString * select = dic[@"Select"];

                if ([select isEqualToString:@"1"])//选中
                {
                    NSMutableArray * array = self.regionAllDataArray[i];

                    if (array)
                    {
                        for (RegionModel * findmodel in array)
                        {
                            if ([findmodel.isSelect isEqualToString:@"1"])
                            {
                                cell.model = findmodel.secondArray[indexPath.section];
                            }
                        }
                    }

                }
            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == self.FirstTbaleview)
    {
        
        for (int i = 0; i < self.regionDefaultArray.count; i++)
        {
             NSMutableDictionary * dic = self.regionDefaultArray[i];
            
            if (i == (int)indexPath.section)
            {
                NSString * TitleName = dic[@"TitleName"];

                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FirstListSelect"];
                [[NSUserDefaults standardUserDefaults] setObject:TitleName forKey:@"FirstListSelect"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                 [dic setObject:@"1" forKey:@"Select"];
            }
            else
            {
                [dic setObject:@"0" forKey:@"Select"];
            }
        }

        //数据默认
        for (NSMutableArray * array in self.regionAllDataArray)
        {
            for (RegionModel * model in array)
            {
                model.isSelect= @"0";

                for (RegionModel * secondmodel in model.secondArray)
                {
                    secondmodel.isSelect = @"0";
                }
            }
        }

         [self ChangeTwoList];

    }
    else if (tableView == self.SecondTbaleview)
    {
        [self SecondDataChange:indexPath];
       
    }
    else if (tableView == self.ThreeTbaleview)
    {
        [self ThreeDataChange:indexPath];
    }
}
//第二个列表数据改变
-(void)SecondDataChange:(NSIndexPath *)indexPath
{

    for(int i = 0; i < self.regionDefaultArray.count;i++)
    {
        NSMutableDictionary * dic = self.regionDefaultArray[i];
        NSString * select = dic[@"Select"];

        if ([select isEqualToString:@"1"])//选中
        {
            NSMutableArray * array = self.regionAllDataArray[i];

            if (array)
            {
                RegionModel * selectmodel = array[indexPath.section];

                for (RegionModel *tempmodel in array)
                {
                    if ([tempmodel isEqual:selectmodel])
                    {
                        tempmodel.isSelect = @"1";

                        if (i == 0)//区域
                        {
                            if ([tempmodel.titleName isEqualToString:UNLIMITEDNAME])//不限
                            {
                                [self ChangeTwoList];

                                if (self.sendDataBlock) {
                                    self.sendDataBlock();
                                }

                                if (self.sendTitleBlock)
                                {
                                    self.sendTitleBlock(DEFAULTREGINNAME);
                                }

                                [[NSNotificationCenter defaultCenter] postNotificationName:@"REGIONCHANGE" object:nil];
                            }
                            else//其它
                            {
                                [self ChangeThreeList];

                            }
                        }
                        else if(i == 1)//捷运
                        {
                            [self ChangeThreeList];
                        }
                        else if (i == 2)//附近
                        {
                            if (self.sendTitleBlock)
                            {
                                self.sendTitleBlock(tempmodel.titleName);
                            }

                            if (self.sendDataBlock)
                            {
                                self.sendDataBlock();
                            }

                            [self.SecondTbaleview reloadData];

                            NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];


                            [dic setObject:NEARBYMNAME forKey:@"type"];
                            [dic setObject:tempmodel forKey:@"model"];
                            [dic setObject:tempmodel forKey:@"secondModel"];
                            //第三列
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"SPECIFIC" object:dic];
                        }

                    }
                    else
                    {
                        tempmodel.isSelect = @"0";

                        for (RegionModel * othermodel in tempmodel.secondArray)
                        {
                            othermodel.isSelect = @"0";
                        }
                    }
                }
            }

        }

    }



}
//第三列数据变换
-(void)ThreeDataChange:(NSIndexPath *)indexPath
{

    for(int i = 0; i < self.regionDefaultArray.count;i++)
    {
        NSMutableDictionary * dic = self.regionDefaultArray[i];
        NSString * select = dic[@"Select"];

        if ([select isEqualToString:@"1"])//选中
        {
            NSMutableArray * array = self.regionAllDataArray[i];

            if (array)
            {
                for (RegionModel * findmodel in array)
                {
                    if ([findmodel.isSelect isEqualToString:@"1"])
                    {
                        RegionModel * selectmodel = findmodel.secondArray[indexPath.section];

                        for (RegionModel * secondmodel in findmodel.secondArray)
                        {
                            if ([selectmodel isEqual:secondmodel])
                            {
                                secondmodel.isSelect = @"1";

                                if ([secondmodel.number isEqualToString:@"0"])//不限
                                {
                                    if (self.sendTitleBlock)
                                    {
                                        self.sendTitleBlock(findmodel.titleName);
                                    }

                                }
                                else
                                {
                                    if (self.sendTitleBlock)
                                    {
                                        self.sendTitleBlock(secondmodel.titleName);
                                    }

                                }

                                if (self.sendDataBlock)
                                {
                                    self.sendDataBlock();
                                }

                                NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];

                                if (i == 0)
                                {
                                    [dic setObject:DEFAULTREGINNAME forKey:@"type"];
                                }
                                else
                                {
                                    [dic setObject:JIEYUNNAME forKey:@"type"];
                                }

                                [dic setObject:findmodel forKey:@"model"];
                                [dic setObject:secondmodel forKey:@"secondModel"];
                                //第三列
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"SPECIFIC" object:dic];
                            }
                            else
                            {
                                secondmodel.isSelect = @"0";
                            }
                        }
                    }

                }
            }
        }

    }

    [self.ThreeTbaleview  reloadData];

}

//变成三列
-(void)ChangeThreeList
{
    CGFloat clearance = 0.5;
    CGFloat TabWidth = SCREEN_WIDTH/3 - clearance*2;
    
    self.FirstTbaleview.hidden = NO;
    self.SecondTbaleview.hidden =NO;
    self.ThreeTbaleview.hidden = NO;
    
    self.FirstTbaleview.frame = CGRectMake(0, 0, TabWidth, CGRectGetHeight(self.frame));
    self.SecondTbaleview.frame = CGRectMake(TabWidth+clearance,0 , TabWidth, CGRectGetHeight(self.frame));
    self.ThreeTbaleview.frame = CGRectMake(TabWidth * 2 + clearance * 2,0 , TabWidth, CGRectGetHeight(self.frame));
    
    [self.SecondTbaleview reloadData];
    [self.ThreeTbaleview reloadData];
}
-(void)ChangeTwoList
{
    CGFloat clearance = 0.5;
    CGFloat TabWidth = SCREEN_WIDTH/2-clearance;
    
    self.FirstTbaleview.hidden = NO;
    self.SecondTbaleview.hidden =NO;
    self.ThreeTbaleview.hidden = YES;
    
    self.FirstTbaleview.frame = CGRectMake(0, 0, TabWidth, CGRectGetHeight(self.frame));
    self.SecondTbaleview.frame = CGRectMake(TabWidth+clearance, 0, TabWidth, CGRectGetHeight(self.frame));
    
    [self.FirstTbaleview reloadData];
    [self.SecondTbaleview reloadData];
}


@end
