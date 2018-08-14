//
//  SearchViewController.h
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic, copy) NSString *recordName; //记录名称

@property (nonatomic, copy) void(^searchNameBlock)(NSString * name); //返回搜索的名字

@end
