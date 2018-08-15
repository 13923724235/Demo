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

@property (nonatomic, strong) NSMutableArray *regionDefaultArray; //区域默认数据

@property (nonatomic, strong) NSMutableArray *regionAllDataArray; //区域数据

@property (nonatomic, strong) NSMutableArray *jieyunAllDataArray; //捷运数据

@property (nonatomic, strong) NSMutableArray *nearbyAllDataArray; //附近数据

@property (nonatomic, strong) UITableView *firstTbaleView; //第一个列表

@property (nonatomic, strong) UITableView *secondTbaleView; //第二个列表

@property (nonatomic, strong) UITableView *threeTbaleView; //第三个列表

@end

@implementation ReginView
{
    NSInteger secondListCount; //第二列表个数
    NSInteger threeListCount;  //第三列表个数
    NSInteger recordSelectIndex; //第二列表点击下标
    
}
#pragma mark Lazy load

- (UITableView *)firstTbaleView
{
    if (!_firstTbaleView)
    {
        _firstTbaleView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _firstTbaleView.dataSource = self;
        _firstTbaleView.delegate  = self;
        _firstTbaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _firstTbaleView.backgroundColor =[UIColor whiteColor];
        _firstTbaleView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
        _firstTbaleView.hidden = YES;
    }
    
    return _firstTbaleView;
}

- (UITableView *)secondTbaleView
{
    if (!_secondTbaleView)
    {
        _secondTbaleView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _secondTbaleView.dataSource = self;
        _secondTbaleView.delegate  = self;
        _secondTbaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _secondTbaleView.backgroundColor =[UIColor whiteColor];
        _secondTbaleView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
        _secondTbaleView.hidden = YES;
    }
    
    return _secondTbaleView;
}

- (UITableView *)threeTbaleView
{
    if (!_threeTbaleView)
    {
        _threeTbaleView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _threeTbaleView.dataSource = self;
        _threeTbaleView.delegate  = self;
        _threeTbaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _threeTbaleView.backgroundColor =[UIColor whiteColor];
        _threeTbaleView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
         _threeTbaleView.hidden = YES;
    }
    
    return _threeTbaleView;
}

- (NSMutableArray *)regionDefaultArray
{
    if (!_regionDefaultArray)
    {
        _regionDefaultArray =[[NSMutableArray alloc] init];

    }

    return _regionDefaultArray;
}


- (NSMutableArray *)regionAllDataArray
{
    if (!_regionAllDataArray)
    {
        _regionAllDataArray =[[NSMutableArray alloc] init];
        
    }
    
    return _regionAllDataArray;
}

- (NSMutableArray *)jieyunAllDataArray
{
    if (!_jieyunAllDataArray)
    {
        _jieyunAllDataArray =[[NSMutableArray alloc] init];
        
    }
    
    return _jieyunAllDataArray;
}

- (NSMutableArray *)nearbyAllDataArray
{
    if (!_nearbyAllDataArray)
    {
        _nearbyAllDataArray =[[NSMutableArray alloc] init];
        
    }
    
    return _nearbyAllDataArray;
}


#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame withTitleData:(NSMutableArray *)titleArray withReginListData:(NSMutableArray *)allReginArray
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor jk_colorWithHexString:@"e7e7e7"];

        self.selecType = ReginListSelectTpyeRegin;
        recordSelectIndex= 0;
        
        [self.regionDefaultArray removeAllObjects];
        [self.regionAllDataArray removeAllObjects];
        [self.jieyunAllDataArray removeAllObjects];
        [self.nearbyAllDataArray removeAllObjects];

        self.regionDefaultArray = titleArray;
      
        if (allReginArray.count == 3)
        {
            self.regionAllDataArray = allReginArray[0];
            self.jieyunAllDataArray = allReginArray[1];
            self.nearbyAllDataArray = allReginArray[2];
        }
        else if (allReginArray.count == 2)
        {
            self.regionAllDataArray = allReginArray[0];
            self.jieyunAllDataArray = allReginArray[1];
        
        }
        
        
        secondListCount = [self getSecondTableiViewSectionCount];
        threeListCount = [self getThreeTableiViewSectionCount];
        
        [self creteUI];

    }

    return self;
}

//移除附近数据
- (void)removeNearbyData
{
    if (self.regionDefaultArray.count == 3)
    {
        [self.regionDefaultArray removeLastObject];
        [self.nearbyAllDataArray removeAllObjects];
    }
    
    
}

- (void)creteUI
{
    [self addSubview:self.firstTbaleView];
    [self addSubview:self.secondTbaleView];
    [self addSubview:self.threeTbaleView];
    
       CGFloat clearance = 0.5;
        CGFloat TabWidth = SCREEN_WIDTH/2-clearance;
        
        self.firstTbaleView.hidden = NO;
        self.secondTbaleView.hidden =NO;
        self.threeTbaleView.hidden = YES;
        
        self.firstTbaleView.frame = CGRectMake(0, 0, TabWidth, CGRectGetHeight(self.frame));
        self.secondTbaleView.frame = CGRectMake(TabWidth+clearance, 0, TabWidth, CGRectGetHeight(self.frame));

}

//是否隐藏
- (void)currentViewIsHidden:(BOOL)isHiden
{
    if (isHiden){
        self.hidden = YES;
    }
    else{
        self.hidden = NO;
    }
}

#pragma  mark Tableview Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.firstTbaleView)
    {
        return self.regionDefaultArray.count;
    }
    else if (tableView == self.secondTbaleView)
    {
        return secondListCount;

    }
    else if (tableView == self.threeTbaleView)
    {
        if (self.threeTbaleView.hidden == YES)
        {
            return  0;
        }
        else
        {
            return threeListCount;
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
    
    if (tableView == self.firstTbaleView)
    {
        NSMutableDictionary * dic = self.regionDefaultArray[indexPath.section];
        
        cell.temoDic = dic;
        
    }
    else if(tableView == self.secondTbaleView)
    {
        RegionModel * newmodel = nil;
        if (self.selecType == ReginListSelectTpyeRegin)//区域
        {
            newmodel = self.regionAllDataArray[indexPath.section];
            
        }
        else if (self.selecType == ReginListSelectTpyeJieYun)//捷运
        {
            newmodel = self.jieyunAllDataArray[indexPath.section];
        }
        else if (self.selecType == ReginListSelectTpyeNearby)//附近
        {
            newmodel = self.nearbyAllDataArray[indexPath.section];
        }
        
        cell.model = newmodel;
       
    }
    else if (tableView == self.threeTbaleView)
    {
        RegionModel * newmodel = nil;
        if (self.selecType == ReginListSelectTpyeRegin)//区域
        {
            newmodel = self.regionAllDataArray[recordSelectIndex];
        }
        else if (self.selecType == ReginListSelectTpyeJieYun)//捷运
        {
            newmodel = self.jieyunAllDataArray[recordSelectIndex];
        }
        
        cell.model = newmodel.secondArray[indexPath.section];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == self.firstTbaleView)
    {
        [self firstDataChange:indexPath];
       
    }
    else if (tableView == self.secondTbaleView)
    {
        recordSelectIndex = indexPath.section;
        [self secondDataChange:indexPath];
       
    }
    else if (tableView == self.threeTbaleView)
    {
        [self threeDataChange:indexPath];
    }
}

//第一个数据列表改变
- (void)firstDataChange:(NSIndexPath *)indexPath
{
    
    WeakSelf(weakSelf)
    
    [self.regionDefaultArray enumerateObjectsUsingBlock:^(NSMutableDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == indexPath.section)
        {
            [dic setObject:@"1" forKey:@"Select"];
            weakSelf.selecType = indexPath.section;
        }
        else
        {
            [dic setObject:@"0" forKey:@"Select"];
        }
        
    }];
    
    [self.regionAllDataArray enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        model.isSelect= @"0";
    }];
    
    [self.jieyunAllDataArray enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        model.isSelect= @"0";
    }];
    
    [self.nearbyAllDataArray enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        model.isSelect= @"0";
    }];
    
     [self changeTwoList];
  
}

//第二个列表数据改变
- (void)secondDataChange:(NSIndexPath *)indexPath
{
    WeakSelf(weakSelf)
    
    if (self.selecType == ReginListSelectTpyeRegin)//区域
    {
        [self.regionAllDataArray enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == indexPath.section)
            {
                model.isSelect= @"1";
                
                if ([model.titleName isEqualToString:UNLIMITEDNAME])//不限
                {
                    [weakSelf sendReginUnlimitedData];
                }
                else//其它
                {
                    [self changeThreeList];
                }
            }
            else
            {
                model.isSelect= @"0";
            }
        }];
    }
    else if (self.selecType == ReginListSelectTpyeJieYun)//捷运
    {
        [self.jieyunAllDataArray enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == indexPath.section)
            {
                model.isSelect= @"1";
                [weakSelf changeThreeList];
            }
            else
            {
                model.isSelect= @"0";
            }
        }];
    }
    else if (self.selecType == ReginListSelectTpyeNearby)//附近
    {
        [self.nearbyAllDataArray enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == indexPath.section)
            {
                model.isSelect= @"1";
                [weakSelf sendNearbyDataWithModel:model];
            }
            else
            {
                model.isSelect= @"0";
            }
        }];
    }
}
//第三列数据变换
- (void)threeDataChange:(NSIndexPath *)indexPath
{
    
    WeakSelf(weakSelf)
    
    NSMutableArray * array =[[NSMutableArray alloc] init];
    
    if (self.selecType == ReginListSelectTpyeRegin)//区域
    {
        array = self.regionAllDataArray;
    }
    else if (self.selecType == ReginListSelectTpyeJieYun)//捷运
    {
         array = self.jieyunAllDataArray;
    }
    
    [array enumerateObjectsUsingBlock:^(RegionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([model.isSelect isEqualToString:@"1"])
        {
            [model.secondArray enumerateObjectsUsingBlock:^(RegionModel * secondModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == indexPath.section)
                {
                    secondModel.isSelect = @"1";
                    
                    if ([secondModel.number isEqualToString:@"0"])//不限
                    {
                        if (weakSelf.sendTitleBlock)
                        {
                            weakSelf.sendTitleBlock(model.titleName);
                        }
                        
                    }
                    else
                    {
                        if (weakSelf.sendTitleBlock)
                        {
                            weakSelf.sendTitleBlock(secondModel.titleName);
                        }
                    }
                    
                    [weakSelf sendThreeLsitDataWithModel:model withSecondModel:secondModel withType:weakSelf.selecType];
                }
                else
                {
                    secondModel.isSelect = @"0";
                }
            }];
        }
    }];
    
    [self.threeTbaleView  reloadData];

}

//变成三列
- (void)changeThreeList
{
    CGFloat clearance = 0.5;
    CGFloat TabWidth = SCREEN_WIDTH/3 - clearance*2;
    
    self.firstTbaleView.hidden = NO;
    self.secondTbaleView.hidden =NO;
    self.threeTbaleView.hidden = NO;
    
    self.firstTbaleView.frame = CGRectMake(0, 0, TabWidth, CGRectGetHeight(self.frame));
    self.secondTbaleView.frame = CGRectMake(TabWidth+clearance,0 , TabWidth, CGRectGetHeight(self.frame));
    self.threeTbaleView.frame = CGRectMake(TabWidth * 2 + clearance * 2,0 , TabWidth, CGRectGetHeight(self.frame));
    
    secondListCount = [self getSecondTableiViewSectionCount];
    threeListCount = [self getThreeTableiViewSectionCount];
    
    [self.secondTbaleView reloadData];
    [self.threeTbaleView reloadData];
    
  
}
//变成两列
- (void)changeTwoList
{
    CGFloat clearance = 0.5;
    CGFloat TabWidth = SCREEN_WIDTH/2-clearance;
    
    self.firstTbaleView.hidden = NO;
    self.secondTbaleView.hidden =NO;
    self.threeTbaleView.hidden = YES;
    
    self.firstTbaleView.frame = CGRectMake(0, 0, TabWidth, CGRectGetHeight(self.frame));
    self.secondTbaleView.frame = CGRectMake(TabWidth+clearance, 0, TabWidth, CGRectGetHeight(self.frame));
    
    secondListCount = [self getSecondTableiViewSectionCount];
    threeListCount = [self getThreeTableiViewSectionCount];
    
    [self.firstTbaleView reloadData];
    [self.secondTbaleView reloadData];
}

//第二个列表个数
- (NSInteger)getSecondTableiViewSectionCount
{
    if (self.selecType == ReginListSelectTpyeRegin)//区域
    {
        return self.regionAllDataArray.count;
    }
    else if (self.selecType == ReginListSelectTpyeJieYun)//捷运
    {
        return self.jieyunAllDataArray.count;
    }
    else if (self.selecType == ReginListSelectTpyeNearby)//附近
    {
        return self.nearbyAllDataArray.count;
    }
    
    return  0;
}
//第三列表个数
- (NSInteger)getThreeTableiViewSectionCount
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if (self.selecType == ReginListSelectTpyeRegin)//区域
    {
        array = [self.regionAllDataArray copy];
    }
    else if (self.selecType == ReginListSelectTpyeJieYun)//捷运
    {
        array = [self.jieyunAllDataArray copy];
    }

    for (RegionModel * model in array)
    {
        if ([model.isSelect isEqualToString:@"1"])
        {
            return model.secondArray.count;
        }
    }
    
    return 0;
}

#pragma mark Send Data
//发送区域不限数据
- (void)sendReginUnlimitedData
{
    [self changeTwoList];
    
    if (self.sendDataBlock) {
        self.sendDataBlock();
    }
    
    if (self.sendTitleBlock)
    {
        self.sendTitleBlock(DEFAULTREGINNAME);
    }
    
    if (self.sendUploadDataBlock)
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:UNLIMITEDNAME forKey:@"type"];
        
        self.sendUploadDataBlock(dic);
        
    }
}
//发送附近数据
- (void)sendNearbyDataWithModel:(RegionModel *)model
{
    if (self.sendTitleBlock)
    {
        self.sendTitleBlock(model.titleName);
    }
    
    if (self.sendDataBlock)
    {
        self.sendDataBlock();
    }
    
    [self.secondTbaleView reloadData];
    
    
    if (self.sendUploadDataBlock)
    {
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
        
        
        [dic setObject:NEARBYMNAME forKey:@"type"];
        [dic setObject:model forKey:@"model"];
        [dic setObject:model forKey:@"secondModel"];
        
        self.sendUploadDataBlock(dic);
    }
}

//发送三级菜单数据
- (void)sendThreeLsitDataWithModel:(RegionModel *)model withSecondModel:(RegionModel *)secondModel withType:(ReginListSelectTpye)type
{
    if (self.sendDataBlock)
    {
        self.sendDataBlock();
    }
    
    if (self.sendUploadDataBlock)
    {
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
        
        if (type == ReginListSelectTpyeRegin)
        {
            [dic setObject:DEFAULTREGINNAME forKey:@"type"];
        }
        else if(type == ReginListSelectTpyeJieYun)
        {
            [dic setObject:JIEYUNNAME forKey:@"type"];
        }
        
        [dic setObject:model forKey:@"model"];
        [dic setObject:secondModel forKey:@"secondModel"];
        
        self.sendUploadDataBlock(dic);
    }
}

@end
