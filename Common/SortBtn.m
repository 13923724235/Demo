//
//  SortBtn.m
//  demo
//
//  Created by addcn on 2018/8/14.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "SortBtn.h"

@implementation SortBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor blackColor];
        //设置button正常状态下的图片
        [self setImage:[UIImage imageNamed:@"icon_jiantou"] forState:UIControlStateNormal];
        //设置button高亮状态下的图片
        [self setImage:[UIImage imageNamed:@"icon_jiantou"] forState:UIControlStateHighlighted];
        
        //button图片的偏移量，距上左下右分别(0, 0, 0, 0)像素点
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self setTitle:@"排序" forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置button正常状态下的标题颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置button高亮状态下的标题颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
       

    }
    
    return self;
}



@end
