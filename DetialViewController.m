//
//  DetialViewController.m
//  yiming
//
//  Created by 攒钱网 on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "DetialViewController.h"
#import "YMDetailDelegate.h"
@interface DetialViewController ()

@end

@implementation DetialViewController
@synthesize ID;
@synthesize Table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
       YMDetailDelegate*  detailDelegate = [[YMDetailDelegate alloc]init];
    [detailDelegate getData:ID m:Table compete:^(NSMutableArray *arr) {
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
