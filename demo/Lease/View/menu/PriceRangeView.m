//
//  PriceRangeView.m
//  demo
//
//  Created by addcn on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "PriceRangeView.h"
#define BootomHeight 44
@implementation PriceRangeView

#pragma mark Lazy load
- (UILabel *)customLabel
{
    if (!_customLabel)
    {
        _customLabel =[[UILabel alloc] init];
        _customLabel.textColor =[UIColor jk_colorWithHexString:@"999999"];
        _customLabel.text = @"自定義";
        _customLabel.font =[UIFont systemFontOfSize:13];
        _customLabel.textAlignment = NSTextAlignmentLeft;
        _customLabel.backgroundColor =[UIColor whiteColor];
    }
    
    return _customLabel;
}

- (UITextField *)minimumPriceField
{
    if (!_minimumPriceField)
    {
        _minimumPriceField =[[UITextField alloc] init];
        // 就下面这两行是重点
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"最小" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"999999"],
                                            NSFontAttributeName:@"14"
                                            }];
        _minimumPriceField.attributedPlaceholder = attrString;
        _minimumPriceField.font =[UIFont systemFontOfSize:14];
         _minimumPriceField.textColor =[UIColor jk_colorWithHexString:@"666666"];
        _minimumPriceField.layer.borderWidth = 0.3;
        _minimumPriceField.layer.cornerRadius = 3.0f;
        _minimumPriceField.clipsToBounds = YES;
        _minimumPriceField.layer.borderColor =[UIColor jk_colorWithHexString:@"999999"].CGColor;
        _minimumPriceField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _minimumPriceField;
}

- (UITextField *)maximumPriceField
{
    if (!_maximumPriceField)
    {
        _maximumPriceField =[[UITextField alloc] init];
        // 就下面这两行是重点
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"最大" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"999999"],
                                            NSFontAttributeName:@"14"
                                            }];
        _maximumPriceField.attributedPlaceholder = attrString;
        _maximumPriceField.font =[UIFont systemFontOfSize:14];
        _maximumPriceField.textColor =[UIColor jk_colorWithHexString:@"666666"];
        _maximumPriceField.layer.borderWidth = 0.3;
        _maximumPriceField.layer.cornerRadius = 3.0f;
        _maximumPriceField .clipsToBounds = YES;
        _maximumPriceField.layer.borderColor =[UIColor jk_colorWithHexString:@"999999"].CGColor;
        _maximumPriceField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _maximumPriceField;
}

- (UILabel *)transverselineLanbel
{
    if (!_transverselineLanbel)
    {
        _transverselineLanbel =[[UILabel alloc] init];
        _transverselineLanbel.textColor =[UIColor jk_colorWithHexString:@"999999"];
        _transverselineLanbel.text = @"—";
        _transverselineLanbel.font =[UIFont systemFontOfSize:14];
        _transverselineLanbel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _transverselineLanbel;
}

- (UILabel *)yuanLabel
{
    if (!_yuanLabel)
    {
        _yuanLabel =[[UILabel alloc] init];
        _yuanLabel.textColor =[UIColor jk_colorWithHexString:@"999999"];
        _yuanLabel.text = @"元";
        _yuanLabel.font =[UIFont systemFontOfSize:14];
        _yuanLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _yuanLabel;
}

- (UIButton *)determineBtn
{
    if (!_determineBtn)
    {
        _determineBtn =[[UIButton alloc] init];
        [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _determineBtn.backgroundColor =[UIColor orangeColor];
        [_determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        _determineBtn.titleLabel.font =[UIFont systemFontOfSize:16];
        _determineBtn.layer.cornerRadius = 3.0f;
        _determineBtn.clipsToBounds = YES;
    }
    
    return _determineBtn;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self == [super initWithFrame:frame])
    {
        [self crerateUI];
    }
    
    return self;
    
}

- (void)crerateUI
{
    
    WeakSelf(weakSelf)
    
    [self addSubview:self.customLabel];
    [self addSubview:self.minimumPriceField];
    [self addSubview:self.maximumPriceField];
    [self addSubview:self.transverselineLanbel];
    [self addSubview:self.yuanLabel];
    [self addSubview:self.determineBtn];
    
    CGFloat priceW = KIsiPhoneX?80:KWIDTHShiPei 60;

    [self.customLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(weakSelf.mas_left).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(45);
    }];
    
    [self.minimumPriceField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.customLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(priceW);
        make.height.mas_equalTo(28);
    }] ;
    
    [self.transverselineLanbel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.minimumPriceField.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.maximumPriceField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.transverselineLanbel.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(priceW);
        make.height.mas_equalTo(28);
    }];
    
    [self.yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.maximumPriceField.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(20);
         make.height.mas_equalTo(20);
    }];
    
    
    [self.determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(priceW);
        make.height.mas_equalTo(28);
    }];
    
}

@end
