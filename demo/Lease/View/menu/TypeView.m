//
//  TypeView.m
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "TypeView.h"
#import "RegionModel.h"
#import "Menulistcell.h"
@interface TypeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *typeArray; //区域数据

@property (nonatomic, strong) UITableView *firstTbaleView; //列表

@end

@implementation TypeView

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


- (NSMutableArray *)typeArray
{
    if (!_typeArray)
    {
        _typeArray =[[NSMutableArray alloc] init];
    }
    
    return _typeArray;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame withListData:(NSMutableArray *)array
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor whiteColor];
        
        [self.typeArray removeAllObjects];
        self.typeArray = array;
        [self creteUI];
        
    }
    
    return self;
}

- (void)creteUI
{
     [self addSubview:self.firstTbaleView];
    
    self.firstTbaleView.hidden = NO;
    
     self.firstTbaleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.frame));
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"Menulistcell";
    Menulistcell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[Menulistcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor whiteColor];
        
    }
    
    RegionModel * model = self.typeArray[indexPath.section];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     RegionModel * model = self.typeArray[indexPath.section];
    
    for (RegionModel *tempmodel in self.typeArray)
    {
        if ([tempmodel isEqual:model])
        {
            tempmodel.isSelect = @"1";

            if (self.sendTitleBlock)
            {
                self.sendTitleBlock(tempmodel.titleName);
            }

            if (self.sendUploadDataBlock)
            {
                NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
                
                [dic setObject:tempmodel forKey:@"model"];
                
                self.sendUploadDataBlock(dic);
            }
      
        }
        else
        {
            tempmodel.isSelect = @"0";
        }
        
    }
    
    [self.firstTbaleView reloadData];
    
}


@end
