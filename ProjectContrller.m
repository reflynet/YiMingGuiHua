//
//  ProjectContrller.m
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//
#import "TongjiController.h"
#import "ProjectContrller.h"
#import "ProjectTypeViewController.h"
#import "YMUITapGestureRecognizer.h"
#import "CityController.h"
#import "YMCommon.h"
#import "ProjectStepViewController.h"
#import "EntityListController.h"
@interface ProjectContrller()
{
    NSString* selectCity;
    NSString* selectProject;
    NSString* selectStep;
    
}

@end


@implementation ProjectContrller
@synthesize ID;
@synthesize viewCity;
@synthesize cellCity;
@synthesize projectType;
@synthesize  projectStep;
@synthesize cellDDD;
@synthesize cellPro;
@synthesize cellSearch;
@synthesize btnSearch;

@synthesize lblProject;
@synthesize lblCity;
@synthesize lblStep;
@synthesize Title;
-(IBAction) searchprogram:(id)sender
{
    TongjiController *ickImageViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"tongji"];
    [self.navigationController pushViewController:ickImageViewController animated:true];

    }


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
      UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(searchprogram:)];
    barbtn.title =@"项目统计";
    self.navigationItem.rightBarButtonItem = barbtn;

    selectCity= @"";
    projectType=  @"";
    projectStep=  @"";
    btnSearch.backgroundColor = [YMCommon hexStringToColor:@"CF0001"];
    btnSearch.layer.cornerRadius = 3.0;
    btnSearch.layer.borderWidth = 1.0;
    btnSearch.layer.borderColor = [[YMCommon hexStringToColor:@"CF0001"] CGColor];
    btnSearch.backgroundColor =[YMCommon hexStringToColor:@"CF0001"];
    
    //添加city选中
    YMUITapGestureRecognizer* singleRecognizer; singleRecognizer =
    [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
    
    singleRecognizer.Table =@"selectcity";
    singleRecognizer.numberOfTouchesRequired = 1; //手指数
    singleRecognizer.numberOfTapsRequired = 1; //tap次数
    
    
    [cellCity addGestureRecognizer:singleRecognizer];
    
    //添加projecttype 选中
    YMUITapGestureRecognizer* singleRecognizer2 =
    [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
    
    singleRecognizer2.Table =@"selectproject";
    singleRecognizer2.numberOfTouchesRequired = 1; //手指数
    singleRecognizer2.numberOfTapsRequired = 1; //tap次数
    
    [cellPro addGestureRecognizer:singleRecognizer2];
    
    //
    //添加projecttype 选中
    YMUITapGestureRecognizer* singleRecognizer3 =
    [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
    
    singleRecognizer3.Table =@"selectprojectstep";
    singleRecognizer3.numberOfTouchesRequired = 1; //手指数
    singleRecognizer3.numberOfTapsRequired = 1; //tap次数
    
    [cellDDD addGestureRecognizer:singleRecognizer3];
    
    
    
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    cellDDD.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cellCity.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cellPro.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    [cellSearch setBackgroundColor:[UIColor clearColor]];
    // cellSearch.separatorStyle = UITableViewCellSelectionStyleNone;
    self.navigationItem.title = Title;
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
    if([tap.Table isEqualToString:@"selectproject"])
    {
        ProjectTypeViewController *ickImageViewController2 =
        [self.storyboard instantiateViewControllerWithIdentifier:@"producttype"];
        // [self presentViewController:ickImageViewController animated:YES completion:nil];
        //ickImageViewController.ID = recognizer.view.tag;
        [self.navigationController presentViewController:ickImageViewController2 animated:true completion:^{
            ickImageViewController2.delegate = self;
        }];
        
    }
    if([tap.Table isEqualToString:@"selectprojectstep"])
    {
        ProjectStepViewController *ickImageViewController3 =
        [self.storyboard instantiateViewControllerWithIdentifier:@"projectstep"];
        // [self presentViewController:ickImageViewController animated:YES completion:nil];
        //ickImageViewController.ID = recognizer.view.tag;
        [self.navigationController presentViewController:ickImageViewController3 animated:true completion:^{
            ickImageViewController3.delegate = self;
        }];
        
    }
    
    
    
    
    
}

-(void)passValue:(int) type value:(NSString *)value{
    if(type == 1)
    {
        selectCity = value;
        lblCity.text = value;
    }
    if(type == 2)
    {
        projectType = value;
        lblProject.text = value;
    }
    if(type == 3)
    {
        projectStep = value;
        lblStep.text = value;
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (IBAction)login:(id)sender {
    EntityListController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EntityList"];
    // controller.ID = current.Id;
    controller.Table = @"project";
    controller.city = selectCity;
    controller.projectType = projectType;
    controller.projectStep = projectStep;
    [YMCommon setBackBtn:self.navigationItem];
    [self.navigationController pushViewController:controller animated:true];
    
    
}
@end
