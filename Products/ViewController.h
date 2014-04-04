//
//  ViewController.h
//  Products
//
//  Created by zhaogyrain on 14-4-4.
//  Copyright (c) 2014年 liweilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> 

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	sqlite3 *db;
}

@property (weak, nonatomic) IBOutlet UIButton *createProductButton;
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@end
