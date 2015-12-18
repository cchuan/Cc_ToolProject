//
//  ViewController.m
//  Cc_ToolProject
//
//  Created by cchuan on 15/12/18.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "ViewController.h"
#import "TakePhoteViewController.h"
#import "CctableViewcontroller.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)actionButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *titleStr = btn.currentTitle;
    
    if ([titleStr isEqualToString:@"takePhotoVC"]) {
        TakePhoteViewController *takePhotoVC = [[TakePhoteViewController alloc] init];
        [self.navigationController pushViewController:takePhotoVC animated:YES];
    } else if ([titleStr isEqualToString:@"tableViewVC"]) {
        CcTableViewController *ccTableViewVC = [[CcTableViewController alloc] init];
        [self.navigationController pushViewController:ccTableViewVC animated:YES];
    }
}

@end
