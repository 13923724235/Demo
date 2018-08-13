//
//  searchView.m
//  demo
//
//  Created by addcn on 2018/8/6.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

#pragma mark Lazy load
-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView =[[UIView alloc] init];
        _bgView.backgroundColor =[UIColor jk_colorWithHexString:@"e27000"];
    
    }

    return _bgView;
}

-(UIImageView *)searchIcon
{
    if (!_searchIcon)
    {
        _searchIcon =[[UIImageView alloc] init];
        _searchIcon.image =[UIImage imageNamed:@"search.png"];
        
    }
    return _searchIcon;
}

-(UITextField *)seaechtextfield
{
    if (!_seaechtextfield)
    {
        _seaechtextfield =[[UITextField alloc] init];
        // 就下面这两行是重点
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入社区,街道,商圈,编号" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"fff7f0"],
                                            NSFontAttributeName:@"12"
                                            }];
        _seaechtextfield.attributedPlaceholder = attrString;
        _seaechtextfield.font =[UIFont systemFontOfSize:12];
        _seaechtextfield.textColor =[UIColor jk_colorWithHexString:@"fff7f0"];
     
    }
    
    return _seaechtextfield;
}

#pragma mark init
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self createUI];
    }
    
    return self;
}


-(void)createUI
{
 
    self.bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    self.bgView.layer.cornerRadius = 30/2;
    self.clipsToBounds = YES;
    
    CGFloat imgH = 15;
    CGFloat teH = 30;
    self.searchIcon.frame = CGRectMake(5,(CGRectGetHeight(self.bgView.frame)-imgH)/2, imgH, imgH);
    self.seaechtextfield.frame = CGRectMake(CGRectGetMaxX(self.searchIcon.frame)+5, 0, CGRectGetWidth(self.frame)-imgH+10, teH);
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.seaechtextfield];
    [self.bgView addSubview:self.searchIcon];
    
    
}




@end
