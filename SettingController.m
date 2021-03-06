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
#import "MRProgress.h"
#import "YMCommon.h"
@implementation SettingController
@synthesize tableView;
@synthesize cellResetPwd;
@synthesize cellCear;

-(void)loadView
{
    self.navigationItem.title = @"用户设置";
    
    
    /* YMUITapGestureRecognizer* singleRecognizer =
     [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
     
     
     YMUITapGestureRecognizer* singleRecognizer2 =
     [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap2:)];
     
     
     cellResetPwd.userInteractionEnabled = true;
     cellCear.userInteractionEnabled = true;
     
     [cellResetPwd addGestureRecognizer:singleRecognizer];
     [cellCear addGestureRecognizer:singleRecognizer2];*/
    [super loadView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSLog([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    
    if(indexPath.row == 2)
    {
         [YMCommon setBackBtn:self.navigationItem];
        RsetPwdController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"resetpwd"];
        [self.navigationController pushViewController:controller animated:true];
    }
    else if (indexPath.row == 1)
    {
        MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
        progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
        progress.mode =MRProgressOverlayViewModeIndeterminate;
        progress.titleLabelText = @"清除缓存中...";
        int64_t delayInSeconds = 3.0;
        
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                                  delayInSeconds * NSEC_PER_SEC);
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
            progress.mode = MRProgressOverlayViewModeCheckmark;

            progress.titleLabelText = @"清除成功";
   
            [progress dismiss:true];
            
        });
        
    }
    else if (indexPath.row == 3)
    {
       
    }
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    
    
}

-(void)SingleTap2:(UITapGestureRecognizer*)recognizer
{
    
    
    
}
@end
