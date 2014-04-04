//
//  DetailViewController.h
//  Products
//
//  Created by zhaogyrain on 14-4-4.
//  Copyright (c) 2014年 liweilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, copy) NSDictionary *jsonDic;

@property (nonatomic, strong) void(^deleteProduct)(void);

@end
