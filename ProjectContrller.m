//
//  ProjectContrller.m
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ProjectContrller.h"
#import "YMUITapGestureRecognizer.h"
#import "CityController.h"

@implementation ProjectContrller
@synthesize ID;
@synthesize viewCity;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    YMUITapGestureRecognizer* singleRecognizer; singleRecognizer =
    [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
    
    singleRecognizer.Table =@"selectcity";
    singleRecognizer.numberOfTouchesRequired = 1; //手指数
    singleRecognizer.numberOfTapsRequired = 1; //tap次数
    
    [viewCity addGestureRecognizer:singleRecognizer];
    
    
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    YMUITapGestureRecognizer *tap = (YMUITapGestureRecognizer *)recognizer;
    
    if([tap.Table isEqualToString:@"selectcity"])
    {
        CityController *ickImageViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"selectcity"];
        // [self presentViewController:ickImageViewController animated:YES completion:nil];
//ickImageViewController.ID = recognizer.view.tag;
        [self.navigationController presentViewController:ickImageViewController animated:true completion:^{
            ickImageViewController.delegate = self;
        }];
        
    }
    
    
    
}

-(void)passValue:(int) type value:(NSString *)value{
    NSLog(@"get backcall value=%@",value);
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
}

@end
