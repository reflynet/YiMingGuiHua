//
//  YMEntityListController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMEntityListController.h"

@interface YMEntityListController ()

@end

@implementation YMEntityListController

@synthesize lblTitle;
@synthesize lblTime;

-(void)layoutSubviews
{
 
    lblTitle.lineBreakMode = UILineBreakModeWordWrap;
    lblTitle.numberOfLines = 3;
}

@end
