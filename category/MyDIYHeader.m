//
//  MyDIYHeader.m
//  demo
//
//  Created by addcn on 2018/8/14.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MyDIYHeader.h"

@interface MyDIYHeader()

@property (nonatomic, weak) UIImageView *myImage; //图片

@property (nonatomic, weak) UILabel *content; //内容


@end

@implementation MyDIYHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 70;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor jk_colorWithHexString:@"999999"];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.content = label;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RefreshPic.png"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.myImage = logo;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    CGFloat imageW = 120;
    CGFloat imageH = 20;
    
    
    self.myImage.frame = CGRectMake((self.mj_w-imageW)/2,20, imageW, imageH);
   
    self.content.frame = CGRectMake((self.mj_w-imageW)/2,CGRectGetMaxY(self.myImage.frame)+10, imageW, 10);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
        {
             self.content.text = @"下拉即可刷新";
             self.content.textColor = [UIColor jk_colorWithHexString:@"999999"];
        }
            break;
        case MJRefreshStatePulling:
        {
             self.content.text = @"释放即可刷新...";
             self.content.textColor = [UIColor jk_colorWithHexString:@"999999"];
        }
            break;
        case MJRefreshStateRefreshing:
        {
            self.content.text = @"载入中...";
            self.content.textColor = [UIColor jk_colorWithHexString:@"999999"];
        }
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    
    self.content.textColor = [UIColor jk_colorWithHexString:@"999999"];
}


@end
