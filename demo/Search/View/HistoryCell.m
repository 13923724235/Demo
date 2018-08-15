//
//  HistoryCell.m
//  demo
//
//  Created by addcn on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (UIImageView *)historyIcon
{
    if (!_historyIcon)
    {
        _historyIcon =[[UIImageView alloc] init];
        _historyIcon.image =[UIImage imageNamed:@"SearchRecord.png"];
        
    }
    
    return _historyIcon;
}

- (UILabel *)historyContent
{
    if (!_historyContent)
    {
        _historyContent =[[UILabel alloc] init];
        _historyContent.textAlignment = NSTextAlignmentLeft;
        _historyContent.font = [UIFont systemFontOfSize:14];
        _historyContent.textColor =[UIColor jk_colorWithHexString:@"666666"];
    }
    
    return _historyContent;
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
    [self.contentView addSubview:self.historyIcon];
    [self.contentView addSubview:self.historyContent];
    [self.contentView addSubview:self.line];
    
    WeakSelf(weakSelf)
    
    [self.historyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.historyContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.historyIcon.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-0.5);
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
