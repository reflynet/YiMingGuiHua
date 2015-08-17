//
//  SettingController.m
//  yiming
//
//  Created by weiwei wei on 15/8/14.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "RsetPwdController.h"
#import "YMUITapGestureRecognizer.h"
#import "SettingController.h"
@implementation SettingController
@synthesize tableView;
@synthesize cellResetPwd;

-(void)loadView
{
    self.navigationItem.title = @"用户设置";
    
    
    YMUITapGestureRecognizer* singleRecognizer; singleRecognizer =
    [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
    
    cellResetPwd.userInteractionEnabled = true;
  
    [cellResetPwd addGestureRecognizer:singleRecognizer];
    [super loadView];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
   
    RsetPwdController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"resetpwd"];
    [self.navigationController pushViewController:controller animated:true];
}
@end
