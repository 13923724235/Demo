//
//  Menulistcell.m
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "Menulistcell.h"

@implementation Menulistcell


- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
       
    }
    
    return _titleLabel;
}

- (UIView *)line
{
    if (!_line)
    {
        _line =[[UIView alloc] init];
        _line.backgroundColor =[UIColor jk_colorWithHexString:@"e7e7e7"];
    }
    
    return _line;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];

    WeakSelf(weakSelf)
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.width.mas_equalTo(weakSelf.contentView.mas_width).multipliedBy(0.8);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
        
    }];
    
 
    
}

- (void)setModel:(RegionModel *)model
{
    NSString * select = model.isSelect;
    
    if ([select isEqualToString:@"1"])
    {
        self.titleLabel.textColor =[UIColor jk_colorWithHexString:@"ff7800"];
    }
    else
    {
        self.titleLabel.textColor =[UIColor jk_colorWithHexString:@"282828"];
    }
    
    self.titleLabel.text = model.titleName;
}

- (void)setTemoDic:(NSMutableDictionary *)temoDic
{
    NSString * select = temoDic[@"Select"];
    
    if ([select isEqualToString:@"1"])
    {
        self.titleLabel.textColor =[UIColor jk_colorWithHexString:@"ff7800"];
    }
    else
    {
        self.titleLabel.textColor =[UIColor jk_colorWithHexString:@"282828"];
    }
    
    NSString * titleName = temoDic[@"TitleName"];
    
    self.titleLabel.text = titleName;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
