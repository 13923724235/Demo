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

@property(nonatomic,strong)NSMutableArray * defaultArray; //默认标题数据

@property(nonatomic,strong)UIView * line; //分割线

@property(nonatomic,strong)UIView * transparentView; //透明图层

@property(nonatomic,strong)UIView * TriangleView; //三角形图标


@end

@implementation MenuView
{
    ReginView * reginView; //区域部分view
    TypeView * typeview; //类型view
    RentView * rentview; //租金view

    NSMutableArray * reginTitleDaraArray;//区域模块标题数据
    NSMutableArray * regonAllDaraArray; //区域列表数据
    NSMutableArray * typeAllDataArray; //类型列表数据
    NSMutableArray * rentAllDataArray; //租金列表数据

}

#pragma mark Lazy load
-(NSMutableArray *)defaultArray
{
    if (!_defaultArray)
    {
        _defaultArray =[[NSMutableArray alloc] init];
    }
    
    return _defaultArray;
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

-(UIView *)transparentView
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

-(UIView *)TriangleView
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
- (void)getrRegionRawDataWithDefault:(NSMutableArray *)defArray withaAllRegionDataMenu:(NSMutableArray *)reginAllArray withTypeRawData:(NSMutableArray *)typeArray withRentRewData:(NSMutableArray *)rentArray
{
    reginTitleDaraArray = [[NSMutableArray alloc] initWithArray:defArray];
    regonAllDaraArray= [[NSMutableArray alloc] initWithArray:reginAllArray];
    typeAllDataArray = [[NSMutableArray alloc] initWithArray:typeArray];
    rentAllDataArray = [[NSMutableArray alloc] initWithArray:rentArray];
}

-(void)createMenuView
{
    for (int i = 0; i < 4; i++)
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
    
    if (button.tag == 100)//区域部分
    {

        if (reginView == nil)
        {

            reginView =[[ReginView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TriangleView.frame)-2, SCREEN_WIDTH, SCREEN_HEIGHT/2) withTitleData:reginTitleDaraArray withReginListData:regonAllDaraArray];


            reginView.sendDataBlock = ^()
            {
                [weakSelf transparentClick];
            };

            NSString * reginDefaultName = self.defaultArray[0];

            if (reginDefaultName == nil)
            {
                reginDefaultName = DEFAULTREGINNAME;
            }

            reginView.sendTitleBlock =^(NSString * Name)
            {
                if ([Name isEqualToString:reginDefaultName])
                {
                     [weakSelf BtnAnmAnimationChangeSecond:button WithName:reginDefaultName];
                }
                else
                {
                      [weakSelf BtnAnmAnimationChangeFirst:button WithName:Name];
                }
            };
            
            [self.superview addSubview:reginView];
        }
        else
        {
            reginView.hidden = NO;
        }
        
        typeview.hidden = YES;
        rentview.hidden = YES;
    }
    else if (button.tag == 101)//类型部分
    {
       
        
        if (typeview == nil)
        {

            typeview =[[TypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TriangleView.frame)-2, SCREEN_WIDTH, SCREEN_HEIGHT/2)withListData:typeAllDataArray];
            
            typeview.sendTitleBlock = ^(NSString *name) {
                
                if ([name isEqualToString:UNLIMITEDNAME])
                {
                   
                    [weakSelf BtnAnmAnimationChangeSecond:button WithName:TYPENAME];
                }
                else
                {
                    [weakSelf BtnAnmAnimationChangeFirst:button WithName:name];
                
                }
                
                [weakSelf transparentClick];
       
            };
            
             [self.superview addSubview:typeview];
        }
        else
        {
            typeview.hidden = NO;
        }
        
         reginView.hidden = YES;
         rentview.hidden = YES;
    }
    else if (button.tag == 102)//租金部分
    {
        if (rentview == nil)
        {

            rentview =[[RentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TriangleView.frame)-2, SCREEN_WIDTH, SCREEN_HEIGHT/2) withListData:rentAllDataArray];
            
            rentview.sendTitleBlock = ^(NSString *name) {
                
                if ([name isEqualToString:UNLIMITEDNAME])
                {

                  [weakSelf BtnAnmAnimationChangeSecond:button WithName:RENTNAME];
                }
                else
                {
                    [weakSelf BtnAnmAnimationChangeFirst:button WithName:name];
                }
                
                [weakSelf transparentClick];
                
            };
            
            rentview.sendDataBlock = ^{
                
                 [weakSelf transparentClick];

            };
            
            [self.superview addSubview:rentview];
        }
        else
        {
            rentview.hidden = NO;
        }
        
        reginView.hidden = YES;
        typeview.hidden = YES;
    }
   
}
#pragma mark Animation
//动画处理 1
-(void)BtnAnmAnimationChangeFirst:(MyselfBtn *)button WithName:(NSString *)name
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
-(void)BtnAnmAnimationChangeSecond:(MyselfBtn *)button WithName:(NSString *)name
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

//透明部分点击
-(void)transparentClick
{
    WeakSelf(weakSelf)

     __strong typeof(weakSelf) strongSelf = weakSelf;

     [UIView animateWithDuration:1.5f animations:^{
         
          self.transparentView.hidden = YES;
         self.TriangleView.hidden = YES;
         strongSelf->reginView.hidden = YES;
         strongSelf->typeview.hidden = YES;
         strongSelf->rentview.hidden = YES;
         
     } completion:^(BOOL finished) {
         
     }];
}


@end
