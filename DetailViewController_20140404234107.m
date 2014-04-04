//
//  DetailViewController.m
//  Products
//
//  Copyright (c) 2014 liweilin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pid;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *regularPrice;
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (weak, nonatomic) IBOutlet UILabel *colors;
@property (weak, nonatomic) IBOutlet UILabel *stores;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCloseButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (IBAction)onDeleteButtonClicked:(id)sender
{
    
}

- (void)showLabelsContent
{
    _pid.text = [_jsonDic objectForKey:@"pid"];
    _name.text = [_jsonDic objectForKey:@"name"];
    _description.text = [_jsonDic objectForKey:@"pdes"];
    _regularPrice.text = [_jsonDic objectForKey:@"regular_price"];
    _salePrice.text = [_jsonDic objectForKey:@"sale_price"];
    _colors.text = [[_jsonDic objectForKey:@"colors"] componentsJoinedByString:@","];
    _stores.text = [[_jsonDic objectForKey:@"stores"] componentsJoinedByString:@","];
    
}

@end
