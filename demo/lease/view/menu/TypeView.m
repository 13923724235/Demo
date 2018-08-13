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

@property(nonatomic,strong)NSMutableArray * TypeArray; //区域数据

@property(nonatomic,strong)UITableView * FirstTbaleview; //列表

@end

@implementation TypeView

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


-(NSMutableArray *)TypeArray
{
    if (!_TypeArray)
    {
        _TypeArray =[[NSMutableArray alloc] init];
    }
    
    return _TypeArray;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame withListData:(NSMutableArray *)array
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor whiteColor];
        
        [self.TypeArray removeAllObjects];
        self.TypeArray = array;
        [self creteUI];
        
    }
    
    return self;
}

-(void)creteUI
{
     [self addSubview:self.FirstTbaleview];
    
    self.FirstTbaleview.hidden = NO;
    
     self.FirstTbaleview.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.frame));
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.TypeArray.count;
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
    
    RegionModel * model = self.TypeArray[indexPath.section];
    
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     RegionModel * model = self.TypeArray[indexPath.section];
    
    for (RegionModel *tempmodel in self.TypeArray)
    {
        if ([tempmodel isEqual:model])
        {
            tempmodel.isSelect = @"1";

            if (self.sendTitleBlock)
            {
                self.sendTitleBlock(tempmodel.titleName);
            }

            NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];

            [dic setObject:tempmodel forKey:@"model"];

            //类型
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TYPE" object:dic];
            
        }
        else
        {
            tempmodel.isSelect = @"0";
        }
        
    }
    
    [self.FirstTbaleview reloadData];
    
}


@end
