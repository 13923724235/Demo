//
//  MyselfBtn.m
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MyselfBtn.h"

#define FONTSIZE 15.f //字体大小

@implementation MyselfBtn

#pragma mark Lazy load
-(UILabel *)btnTitle
{
    if (!_btnTitle) {
        _btnTitle = [[UILabel alloc]init];
        _btnTitle.textAlignment = NSTextAlignmentCenter;
        [_btnTitle sizeToFit];
        [self addSubview:_btnTitle];
    }
    return _btnTitle;
}

-(UIImageView *)imgArrow
{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"downArrow.png"]];
        [self addSubview:_imgArrow];
    }
    return _imgArrow;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //按钮点击响应事件
        [self addTarget:self action:@selector(clickResponce:) forControlEvents:UIControlEventTouchUpInside] ;
        [self btnTitle];
        [self imgArrow];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imgSize = [UIImage imageNamed:@"downArrow.png"].size;
    CGFloat lbW = [self resultsHeight:self.btnTitle.text withFont:15.f];

    if (lbW > 80)
    {
        lbW = 60;
    }

    //标题位置
    _btnTitle.frame = CGRectMake(0, 0,lbW, self.height);
    _btnTitle.x = (self.width - lbW - imgSize.width )/2;
    _btnTitle.centerY = self.centerY;
    
    //指示位置
    _imgArrow.frame  = CGRectMake(0, 0, imgSize.width, imgSize.height);
    _imgArrow.centerY = _btnTitle.centerY;
    _imgArrow.x = _btnTitle.maxX +5;
    
    
}

#pragma mark Click Events
- (void)clickResponce:(MyselfBtn *)btn
{
    if (_block) {
        _block(btn);
    }
    
}

- (CGFloat)resultsHeight:(NSString *)str withFont:(CGFloat)font
{
    CGSize maxSize = CGSizeMake(MAXFLOAT,self.height);
    CGFloat btnPromptW = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:(font)]} context:nil].size.width ;
    return btnPromptW;
}



//初始化
+ (instancetype )newCreateButton
{
    return [MyselfBtn buttonWithType:UIButtonTypeCustom];
}

@end
