//
//  HistoryCell.h
//  demo
//
//  Created by addcn on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell

@property (nonatomic, strong) UIImageView *historyIcon; //历史图标

@property (nonatomic, strong) UILabel *historyContent; //历史内容

@property (nonatomic, strong) UIView *line; //分割线

@end
