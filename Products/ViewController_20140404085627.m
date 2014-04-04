//
//  ViewController.m
//  Products
//
//  Created by zhaogyrain on 14-4-4.
//  Copyright (c) 2014 liweilin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    //==Json path
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
    //==Json
    NSData *data=[NSData dataWithContentsOfFile:Json_path];
    //==JsonObject

    id jsonobject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    NSLog (@"%@",jsonobject);print json dic
    // Dispose of any resources that can be recreated.
}

@end
