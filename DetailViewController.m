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
    [self showLabelsContent];
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
    _deleteProduct();
    // back to pre view
    [self onCloseButtonClicked:nil];
}

- (void)showLabelsContent
{
    _pid.text = [NSString stringWithFormat:@"id is: %@", [_jsonDic objectForKey:@"id"]];
    _name.text = [NSString stringWithFormat:@"name is: %@", [_jsonDic objectForKey:@"name"]];
    _description.text = [NSString stringWithFormat:@"description is: %@", [_jsonDic objectForKey:@"description"]];
    _regularPrice.text = [NSString stringWithFormat:@"regular price is: %@", [_jsonDic objectForKey:@"regular price"]];
    _salePrice.text = [NSString stringWithFormat:@"sale price is: %@", [_jsonDic objectForKey:@"sale price"]];
    _colors.text = [NSString stringWithFormat:@"colors is: %@", [_jsonDic objectForKey:@"colors"]];
    _stores.text = [NSString stringWithFormat:@"stores is: %@", [_jsonDic objectForKey:@"stores"]];
    
}

@end
