//
//  RentingCell.m
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "RentingCell.h"

@implementation RentingCell

-(UIImageView *)photo
{
    if (!_photo)
    {
        _photo =[[UIImageView alloc] init];
        
    }
    
    return _photo;
}

-(UIImageView *)typePhoto
{
    if (!_typePhoto)
    {
        _typePhoto =[[UIImageView alloc] init];
        
    }
    
    return _typePhoto;
}

-(UIImageView *)is_onlinePhoto
{
    if (!_is_onlinePhoto)
    {
        _is_onlinePhoto =[[UIImageView alloc] init];
        _is_onlinePhoto.image =[UIImage imageNamed:@"On_ine.png"];
    }
    
    return _is_onlinePhoto;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor =[UIColor jk_colorWithHexString:@"282828"];
    }
    
    return _titleLabel;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        _addressLabel =[[UILabel alloc] init];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.textColor =[UIColor jk_colorWithHexString:@"888888"];
    }
    
    return _addressLabel;
}

-(UILabel *)arearessLabel
{
    if (!_arearessLabel)
    {
        _arearessLabel =[[UILabel alloc] init];
        _arearessLabel.textAlignment = NSTextAlignmentLeft;
        _arearessLabel.font = [UIFont systemFontOfSize:13];
        _arearessLabel.textColor =[UIColor jk_colorWithHexString:@"888888"];
    }
    
    return _arearessLabel;
}


-(UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        _priceLabel =[[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:16];
        _priceLabel.textColor =[UIColor jk_colorWithHexString:@"ff4400"];
    }
    
    return _priceLabel;
}

-(UIView *)line
{
    if (!_line)
    {
        _line =[[UIView alloc] init];
        _line.backgroundColor =[UIColor jk_colorWithHexString:@"e7e7e7"];
    }
    
    return _line;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.typePhoto];
    [self.contentView addSubview:self.is_onlinePhoto];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.arearessLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.line];
    
    WeakSelf(weakSelf)
    
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(weakSelf.photo.mas_height).multipliedBy(1.3333);
        
    }];
    
    [self.typePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.photo.mas_left).offset(5);
        make.top.mas_equalTo(weakSelf.photo.mas_top);
        make.width.mas_equalTo(weakSelf.photo.mas_width).multipliedBy(0.1535);
        make.height.mas_equalTo(weakSelf.typePhoto.mas_width).multipliedBy(1.6842);
    }];
    
    [self.is_onlinePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.photo.mas_left).offset(5);
        make.bottom.mas_equalTo(weakSelf.photo.mas_bottom);
        make.width.mas_equalTo(weakSelf.typePhoto.mas_width).multipliedBy(0.95);
        make.height.mas_equalTo(weakSelf.is_onlinePhoto.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.photo.mas_right).offset(10);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(weakSelf.photo.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.photo.mas_right).offset(10);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-15);
        make.centerY.mas_equalTo(weakSelf.photo.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    [self.arearessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.photo.mas_right).offset(10);
        make.bottom.mas_equalTo(weakSelf.photo.mas_bottom).offset(-3);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(weakSelf.photo.mas_bottom).offset(-3);
        make.left.mas_equalTo(weakSelf.arearessLabel.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
   
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-0.5);
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.height.mas_equalTo(0.5);
    }];
    
    
}

-(void)setModel:(DataModel *)model
{
    
    [self.photo sd_setImageWithURL:[NSURL URLWithString:model.photo_src] placeholderImage:[UIImage imageNamed:@"NHPlaceholder.png"]];
    
    self.titleLabel.text = model.title;
    
    self.addressLabel.text = model.address;
    
    self.arearessLabel.text = model.area;
    
    self.priceLabel.text = model.price;
    
    if ([model.is_online isEqualToString:@"1"])
    {
        self.is_onlinePhoto.hidden = NO;
    }
    else
    {
        self.is_onlinePhoto.hidden = YES;
    }
    
    if ([model.is_mvip isEqualToString:@"2"])
    {
        self.typePhoto.hidden = NO;
        self.typePhoto.image =[UIImage imageNamed:@"Selected.png"];
    }
    else if ([model.is_mvip isEqualToString:@"1"])
    {
         self.typePhoto.hidden = NO;
        self.typePhoto.image =[UIImage imageNamed:@"setTop.png"];
    }
    else
    {
        self.typePhoto.hidden = YES;
    }
    
    
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
