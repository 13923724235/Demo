//
//  SortView.m
//  demo
//
//  Created by addcn on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "SortView.h"
#import "RegionModel.h"
#import "Menulistcell.h"
@interface SortView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray * sortArray; //排序数据

@property(nonatomic,strong) UITableView * listTableView; //排序列表

@property(nonatomic,strong) UIView * bgView; //背景view

@end

@implementation SortView

#pragma mark Lazy load
- (UITableView *)listTableView
{
    if (!_listTableView)
    {
        _listTableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.dataSource = self;
        _listTableView.delegate  = self;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor =[UIColor whiteColor];
        _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
    }
    
    return _listTableView;
}

-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView =[[UIView alloc] init];
        _bgView.backgroundColor =[UIColor blackColor];
        _bgView.alpha = 0.6;
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgviewclick)];
        
        [_bgView addGestureRecognizer:tap];
    }
    
    return _bgView;
}


-(NSMutableArray *)sortArray
{
    if (!_sortArray)
    {
        _sortArray =[[NSMutableArray alloc] init];
    }
    
    return _sortArray;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame withListData:(NSMutableArray *)array
{
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]])
    {
       
       [self.sortArray removeAllObjects];
        self.sortArray = array;
        [self creteUI];
        
    }
    
    return self;
}

//创建视图
-(void)creteUI
{
    WeakSelf(weakSelf)
    
     [self addSubview:self.bgView];
     [self addSubview:self.listTableView];
   
 
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(weakSelf.bgView.mas_height).multipliedBy(0.3333);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
 
}
#pragma mark Click Events
-(void)bgviewclick
{
     [self removeFromSuperview];
}

#pragma  mark Tableview Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.sortArray.count;
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
    
    RegionModel * model = self.sortArray[indexPath.section];
    
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    RegionModel * model = self.sortArray[indexPath.section];
    
    for (RegionModel *tempmodel in self.sortArray)
    {
        if ([tempmodel isEqual:model])
        {
            tempmodel.isSelect = @"1";
            
            //自定对象归档后在存
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempmodel];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SortListSelect"];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SortListSelect"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            

    
            //排序
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SORT" object:nil];
            
        }
        else
        {
            tempmodel.isSelect = @"0";
        }
        
    }
    
    [self.listTableView reloadData];
    
    [self removeFromSuperview];
   
}


@end
