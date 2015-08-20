//
//  ProjectDetailViewController.m
//  yiming
//
//  Created by 攒钱网 on 15/8/20.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ProjectDetailViewController.h"


@interface ProjectDetailViewController ()

@end

@implementation ProjectDetailViewController
@synthesize ID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSString* requestUrl = [NSString stringWithFormat:@"http://ymoffice.testweb.iwanshang.cn/show.php?id=%d&m=1",ID];
    
    NSURL *url =[NSURL URLWithString:requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.uiWebView loadRequest:request];
      
      
      UIScrollView *tempView = (UIScrollView *)[self.uiWebView.subviews objectAtIndex:0];
    tempView.bounces=NO;
}
@end
