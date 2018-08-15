//
//  MyRefreshProgressView.m
//  demo
//
//  Created by addcn on 2018/8/14.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MyRefreshProgressView.h"

@implementation MyRefreshProgressView

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    
    CGFloat radius = rect.size.width * 0.5 - 10;
    
    CGFloat startA = -M_PI_2;
    
    CGFloat angle = self.progressValue * M_PI * 2;
    
    CGFloat endA = startA + angle;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    CGContextAddPath(ref, path.CGPath);
    
    CGContextStrokePath(ref);
}



@end
