//
//  RentView.m
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "RentView.h"
#import "RegionModel.h"
#import "Menulistcell.h"
#import "PriceRangeView.h"
#define BootomHeight 44
@interface RentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * rentArray; //租金数据

@property (nonatomic, strong) UITableView * firstTbaleView; //列表

@property (nonatomic, strong) PriceRangeView * priceRangeView; //自定义价格View

@end

@implementation RentView

#pragma mark Lazy load

- (PriceRangeView *)priceRangeView
{
    if (!_priceRangeView)
    {
        _priceRangeView =[[PriceRangeView alloc] init];
        _priceRangeView.backgroundColor =[UIColor jk_colorWithHexString:@"fafafa"];
        [_priceRangeView.determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
    }
    
    return _priceRangeView;
}

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


- (NSMutableArray *)rentArray
{
    if (!_rentArray)
    {
        _rentArray =[[NSMutableArray alloc] init];
    }
    
    return _rentArray;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame withListData:(NSMutableArray *)array
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor whiteColor];
        
         [self.rentArray removeAllObjects];
        self.rentArray = array;
        [self creteUI];
        
    }
    
    return self;
}


- (void)creteUI
{
    self.firstTbaleView.hidden = NO;
    self.firstTbaleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.frame)-BootomHeight);
    [self addSubview:self.firstTbaleView];
    self.priceRangeView.frame = CGRectMake(0, CGRectGetMaxY(self.firstTbaleView.frame), SCREEN_WIDTH, BootomHeight);
    [self addSubview:self.priceRangeView];
    
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


#pragma mark Click Events
- (void)determineBtnClick
{
    
    if (self.priceRangeView.maximumPriceField.text.length > 0 && self.priceRangeView.minimumPriceField.text.length > 0){
        
        if (self.priceRangeView.maximumPriceField.text.intValue < self.priceRangeView.minimumPriceField.text.intValue){
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"请输入值大于最小金额" duration:2.0f position:[NSValue valueWithCGPoint:[[[UIApplication sharedApplication] delegate] window].center]];
            
            return;
        }
    }

    if(self.sendDataBlock){
        
        self.sendDataBlock();
    }

    if ([self.priceRangeView.maximumPriceField.text isEqualToString:@""] && [self.priceRangeView.minimumPriceField.text isEqualToString:@""]){
        return;
    }
    else
    {
       
        if (self.sendTitleBlock)
        {
            if ([self.priceRangeView.minimumPriceField.text isEqualToString:@""])//最小
            {
                self.sendTitleBlock([NSString stringWithFormat:@"%@元",self.priceRangeView.maximumPriceField.text]);
            }
            else if ([self.priceRangeView.maximumPriceField.text isEqualToString:@""])
            {
                self.sendTitleBlock([NSString stringWithFormat:@"%@元",self.priceRangeView.minimumPriceField.text]);
            }
            else if (self.priceRangeView.maximumPriceField.text.length > 0 && self.priceRangeView.minimumPriceField.text.length > 0)
            {
                self.sendTitleBlock([NSString stringWithFormat:@"%@-%@元",self.priceRangeView.minimumPriceField.text,self.priceRangeView.maximumPriceField.text]);
            }
            
        }
        
       
        if (self.sendUploadDataBlock)
        {
            NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
            
            if (self.priceRangeView.minimumPriceField.text.length > 0)
            {
                [dic setObject:self.priceRangeView.minimumPriceField.text forKey:@"Min"];
            }
            
            if (self.priceRangeView.maximumPriceField.text.length > 0)
            {
                [dic setObject:self.priceRangeView.maximumPriceField.text forKey:@"Max"];
            }
            
            self.sendUploadDataBlock(dic);
        }

        for (RegionModel *tempmodel in self.rentArray)
        {
            tempmodel.isSelect = @"0";
        }
        
        [self.firstTbaleView reloadData];
        
    }

    [self.priceRangeView.minimumPriceField resignFirstResponder];
    [self.priceRangeView.maximumPriceField resignFirstResponder];

   
    
    
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
    
    return self.rentArray.count;
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
    
    RegionModel * model = self.rentArray[indexPath.section];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RegionModel * model = self.rentArray[indexPath.section];
    
    for (RegionModel *tempmodel in self.rentArray)
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

    self.priceRangeView.minimumPriceField.text = @"";
    self.priceRangeView.maximumPriceField.text = @"";
    [self.priceRangeView.minimumPriceField resignFirstResponder];
    [self.priceRangeView.maximumPriceField resignFirstResponder];

    [self.firstTbaleView reloadData];
}

@end
