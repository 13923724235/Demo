//
//  MenuView.m
//  demo
//
//  Created by addcn on 2018/8/7.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MenuView.h"
#import "MyselfBtn.h"
#import "ReginView.h"
#import "TypeView.h"
#import "RentView.h"

#define LBTITLE_WIDTH (SCREEN_WIDTH/4) //默认的lab宽度

@interface MenuView ()

@property (nonatomic, strong) NSMutableArray *defaultArray; //默认标题数据

@property (nonatomic, strong) UIView *line; //分割线

@property (nonatomic, strong) UIView *transparentView; //透明图层

@property (nonatomic, strong) UIView *TriangleView; //三角形图标

@property (nonatomic, strong) TypeView *typeView; //类型View

@property (nonatomic, strong) RentView *rentView; //租金View

@property (nonatomic, strong) ReginView *reginView; //区域View

@end

@implementation MenuView
{
    
    NSMutableArray *reginTitleDaraArray;//区域模块标题数据
    NSMutableArray *regonAllDaraArray; //区域列表数据
    NSMutableArray *typeAllDataArray; //类型列表数据
    NSMutableArray *rentAllDataArray; //租金列表数据

}

#pragma mark Lazy load

- (ReginView *)reginView
{
    if (!_reginView)
    {
        _reginView = [[ReginView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TriangleView.frame)-2, SCREEN_WIDTH, SCREEN_HEIGHT/2) withTitleData:reginTitleDaraArray withReginListData:regonAllDaraArray];
        [_reginView currentViewIsHidden:YES];
    }
    return _reginView;
}

- (TypeView *)typeView
{
    if (!_typeView)
    {
        _typeView = [[TypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TriangleView.frame)-2, SCREEN_WIDTH, SCREEN_HEIGHT/2)withListData:typeAllDataArray];
        [_typeView currentViewIsHidden:YES];
    }
    return _typeView;
}

- (RentView *)rentView
{
    if (!_rentView)
    {
        _rentView = [[RentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TriangleView.frame)-2, SCREEN_WIDTH, SCREEN_HEIGHT/2) withListData:rentAllDataArray];
        [_rentView currentViewIsHidden:YES];
    }
    return _rentView;
}

- (NSMutableArray *)defaultArray
{
    if (!_defaultArray)
    {
        _defaultArray =[[NSMutableArray alloc] init];
    }
    return _defaultArray;
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

- (UIView *)transparentView
{
    if (!_transparentView)
    {
        _transparentView =[[UIView alloc] init];
        _transparentView.backgroundColor =[UIColor blackColor];
        _transparentView.alpha = 0.6;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transparentClick)];
        _transparentView.hidden = YES;
        [_transparentView addGestureRecognizer:tapGesture];
    }
    return _transparentView;
}

- (UIView *)TriangleView
{
    if (!_TriangleView)
    {
        _TriangleView =[[UIView alloc] init];
        _TriangleView.center =  CGPointMake(LBTITLE_WIDTH/2, CGRectGetMinY(self.transparentView.frame)+4);
        _TriangleView.bounds = CGRectMake(0, 0, 12, 8);
        CAShapeLayer * shapelayer = [CAShapeLayer layer];
        shapelayer.position = CGPointMake(6, 4);
        shapelayer.bounds = CGRectMake(0, 0, 12, 8);
        shapelayer.fillColor = [UIColor whiteColor].CGColor;
        [_TriangleView.layer addSublayer:shapelayer];
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(6, 0)];
        [bezierPath addLineToPoint:CGPointMake(0, 8)];
        [bezierPath addLineToPoint:CGPointMake(12, 8)];
        [bezierPath addLineToPoint:CGPointMake(6, 0)];
        shapelayer.path = bezierPath.CGPath;
        _TriangleView.hidden = YES;
    }
    return _TriangleView;
}


#pragma mark init
//初始化
- (instancetype)initWithFrame:(CGRect)frame withMenuTile:(NSArray *)array withFaterView:(UIView *)faterview
{
    if (self == [super initWithFrame:frame])
    {
        self.frame = frame;
        [faterview addSubview:self];
        [self.defaultArray addObjectsFromArray:array];
        self.backgroundColor =[UIColor whiteColor];
    
        [self createMenuView];
    }
    return self;
}
//区域数据初始化
- (void)getrRegionRawDataWithDefaultArr:(NSMutableArray *)defArray
                          reginAllArray:(NSMutableArray *)reginAllArray
                              typeArray:(NSMutableArray *)typeArray
                              rentArray:(NSMutableArray *)rentArray
{
    reginTitleDaraArray = [[NSMutableArray alloc] initWithArray:defArray];
    regonAllDaraArray= [[NSMutableArray alloc] initWithArray:reginAllArray];
    typeAllDataArray = [[NSMutableArray alloc] initWithArray:typeArray];
    rentAllDataArray = [[NSMutableArray alloc] initWithArray:rentArray];

    [self createOtherView];
}
//创建菜单数据
- (void)createMenuView
{
    for (int i = 0; i < self.defaultArray.count; i++)
    {
        MyselfBtn * btn =[MyselfBtn newCreateButton];
        btn.frame = CGRectMake(i * LBTITLE_WIDTH, 0, LBTITLE_WIDTH, 44);
        btn.btnTitle.text = self.defaultArray[i];
        btn.btnTitle.textColor =[UIColor jk_colorWithHexString:@"282828"];
        btn.btnTitle.font =[UIFont systemFontOfSize:15];
        btn.tag = 100+i;
        btn.backgroundColor  =[UIColor jk_colorWithHexString:@"fafafa"];
        [btn addTarget:self action:@selector(clickEventMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    //分割线
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.frame)-0.5, SCREEN_WIDTH, 0.5);
    [self addSubview:self.line];
    
    self.transparentView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), SCREEN_WIDTH, CGRectGetHeight(self.superview.frame)-CGRectGetHeight(self.frame));
    
    [self.superview addSubview:self.transparentView];
    [self.superview addSubview:self.TriangleView];
}
//创建其他视图
- (void)createOtherView
{
    WeakSelf(weakSelf)
    self.typeView.sendUploadDataBlock = ^(NSMutableDictionary *uploadDic){ //类型
        if (uploadDic){
            if (weakSelf.backTypeDataBlock)
            {
                weakSelf.backTypeDataBlock(uploadDic);
            }
        }
    };
    self.rentView.sendDataBlock = ^{
        [weakSelf transparentClick];
    };
    self.rentView.sendUploadDataBlock=^(NSMutableDictionary *uploadDic){ //租金
        if (uploadDic)
        {
            if (weakSelf.backRentDataBlock)
            {
                weakSelf.backRentDataBlock(uploadDic);
            }
        }
    };
    self.reginView.sendDataBlock = ^(){ //区域
        [weakSelf transparentClick];
    };
    self.reginView.sendUploadDataBlock = ^(NSMutableDictionary * uploadDic){
        if (uploadDic)
        {
            if (weakSelf.backRrginDataBlock)
            {
                weakSelf.backRrginDataBlock(uploadDic);
            }
        }
    };
    
    [self.superview addSubview:self.rentView];
    [self.superview addSubview:self.typeView];
    [self.superview addSubview:self.reginView];
}

#pragma mark Click Events
//菜单按钮点击事件
- (void)clickEventMenu:(MyselfBtn *)button
{
    WeakSelf(weakSelf)
    [UIView animateWithDuration:0.4f animations:^{
        
        self.transparentView.hidden = NO;
        self.TriangleView.center = CGPointMake(button.center.x, CGRectGetMinY(self.transparentView.frame)+4);
        self.TriangleView.hidden = NO;

    } completion:^(BOOL finished) {
        
    }];
    
    if (button.tag == 100){//区域部分
        
        NSString * reginDefaultName = self.defaultArray[0];
        if (reginDefaultName == nil){
            reginDefaultName = DEFAULTREGINNAME;
        }
        self.reginView.sendTitleBlock =^(NSString * Name){
                
            if ([Name isEqualToString:reginDefaultName]){
                [weakSelf btnAnmAnimationChangeSecond:button WithName:reginDefaultName];
            }
            else{
                [weakSelf btnAnmAnimationChangeFirst:button WithName:Name];
            }
        };
        
        if (self.rentView){
            if (![self isLocationServiceOpen]){//没有开启定位
                [self.reginView removeNearbyData];
            }
        }
        [self.reginView currentViewIsHidden:NO];
        [self.typeView currentViewIsHidden:YES];
        [self.rentView currentViewIsHidden:YES];
    }
    else if (button.tag == 101){//类型部分
    
        self.typeView.sendTitleBlock = ^(NSString *name) {

        if ([name isEqualToString:UNLIMITEDNAME]){
            [weakSelf btnAnmAnimationChangeSecond:button WithName:TYPENAME];
        }
        else{
            [weakSelf btnAnmAnimationChangeFirst:button WithName:name];
        }
            
        [weakSelf transparentClick];
        };
        [self.typeView currentViewIsHidden:NO];
        [self.reginView currentViewIsHidden:YES];
        [self.rentView currentViewIsHidden:YES];
    }
    else if (button.tag == 102)//租金部分
    {
        self.rentView.sendTitleBlock = ^(NSString *name) {

        if ([name isEqualToString:UNLIMITEDNAME])
        {
            [weakSelf btnAnmAnimationChangeSecond:button WithName:RENTNAME];
        }
        else
        {
            [weakSelf btnAnmAnimationChangeFirst:button WithName:name];
        }
            
        [weakSelf transparentClick];
        };
        [self.rentView currentViewIsHidden:NO];
        [self.reginView currentViewIsHidden:YES];
        [self.typeView currentViewIsHidden:YES];
    }
}
#pragma mark Animation
//动画处理 1
- (void)btnAnmAnimationChangeFirst:(MyselfBtn *)button WithName:(NSString *)name
{
    [UIView animateWithDuration:0.3f animations:^{

        button.btnTitle.text = name;
        button.btnTitle.textColor =[UIColor jk_colorWithHexString:@"ff7800"];
        button.imgArrow.image = [UIImage imageNamed:@"downOrangeArrow.png"];
        CGAffineTransform imgtransform= CGAffineTransformMakeRotation(M_PI);
        button.imgArrow.transform = imgtransform;
        [button layoutSubviews];

    } completion:^(BOOL finished) {
        
    }];
}
//动画处理2
- (void)btnAnmAnimationChangeSecond:(MyselfBtn *)button WithName:(NSString *)name
{
    [UIView animateWithDuration:0.3f animations:^{
        
        button.btnTitle.text = name;
        button.imgArrow.image = [UIImage imageNamed:@"downArrow.png"];
        CGAffineTransform imgtransform= CGAffineTransformMakeRotation(M_PI*2);
        button.imgArrow.transform = imgtransform;
        button.btnTitle.textColor =[UIColor jk_colorWithHexString:@"282828"];
        [button layoutSubviews];
        
    } completion:^(BOOL finished) {
        
    }];
}

//判断用户是否开启定位
- (BOOL)isLocationServiceOpen
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        return NO;
    }
    else{
        return YES;
    }
}


//透明部分点击
- (void)transparentClick
{
     [UIView animateWithDuration:1.5f animations:^{
         
        self.transparentView.hidden = YES;
        self.TriangleView.hidden = YES;
        [self.reginView currentViewIsHidden:YES];
        [self.rentView currentViewIsHidden:YES];
        [self.typeView currentViewIsHidden:YES];
         
     } completion:^(BOOL finished) {
     }];
}


@end
