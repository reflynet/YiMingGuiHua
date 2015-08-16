//
//  MemberController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//
#import <ImageLoader/UIImageView+ImageLoader.h>
#import "MemberController.h"
#import "YMContactCustomerEntity.h"
#import "YMCommon.h"
#import "MRProgress.h"
@interface MemberController ()
@property MRProgressOverlayView* progress;
@end

@implementation MemberController
@synthesize progress;
@synthesize  member;
@synthesize  imgHead;
@synthesize  lblRealName;
@synthesize  lblDes;
@synthesize  lblTel;
@synthesize  lblPhone;
@synthesize  lblMail;

- (void)viewDidLoad {
    if (member != nil) {
    
        
       NSString* image =  [[YMCommon getServer] stringByAppendingString: member.FacePhoto ];
        
        self.imgHead.layer.cornerRadius = self.imgHead.frame.size.width / 2;
        self.imgHead.clipsToBounds = YES;
        self.imgHead.layer.borderWidth = 1.0f;
        self.imgHead.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self.imgHead setImageWithURL:[NSURL URLWithString:image]];

        self.lblDes.text = [NSString stringWithFormat:@"%@/%@",member.Job,member.Department];
        self.lblRealName.text = member.RealName;
        self.lblTel.text = member.TelPhone;
        self.lblPhone.text = member.Phone;
        self.lblMail.text =member.Email;
        self.btnSave.backgroundColor = [YMCommon hexStringToColor:@"CF0001"];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)save:(id)sender {
    [YMCommon saveAddress:member.RealName tel:member.TelPhone phone:member.Phone];
    
    progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeCheckmark;
    progress.titleLabelText = @"保存成功";
         int64_t delayInSeconds = 3.0;
       dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                              delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        
        
        [progress dismiss:true];
        
    });


}
@end
