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
#import "YMCommon.h"

@implementation ProjectContrller
@synthesize ID;
@synthesize viewCity;
@synthesize cellCity;
@synthesize cellDDD;
@synthesize cellPro;
@synthesize cellSearch;
@synthesize btnSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnSearch.backgroundColor = [YMCommon hexStringToColor:@"CF0001"];
    btnSearch.layer.cornerRadius = 3.0;
    btnSearch.layer.borderWidth = 1.0;
    btnSearch.layer.borderColor = [[YMCommon hexStringToColor:@"CF0001"] CGColor];
    btnSearch.backgroundColor =[YMCommon hexStringToColor:@"CF0001"];

    YMUITapGestureRecognizer* singleRecognizer; singleRecognizer =
    [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
    
    singleRecognizer.Table =@"selectcity";
    singleRecognizer.numberOfTouchesRequired = 1; //手指数
    singleRecognizer.numberOfTapsRequired = 1; //tap次数
    
    [cellCity addGestureRecognizer:singleRecognizer];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    cellDDD.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cellCity.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cellPro.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        [cellSearch setBackgroundColor:[UIColor clearColor]];
     // cellSearch.separatorStyle = UITableViewCellSelectionStyleNone;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

@end
