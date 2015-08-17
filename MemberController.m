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
#import "YMUITapGestureRecognizer.h"
@interface MemberController ()
@property MRProgressOverlayView* progress;
@end

@implementation MemberController
@synthesize viewD;
@synthesize cellTel;
@synthesize progress;
@synthesize  member;
@synthesize  imgHead;
@synthesize  lblRealName;
@synthesize  lblDes;
@synthesize  lblTel;
@synthesize  lblPhone;
@synthesize  lblMail;

- (void)viewDidLoad {
    viewD.hidden  = true;
    if (member != nil) {
        viewD.layer.masksToBounds = YES;
        viewD.layer.cornerRadius = 3.0;
        viewD.layer.borderWidth = 1.0;
        viewD.layer.borderColor = [[YMCommon hexStringToColor:@"eeeeee"] CGColor];
        viewD.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        viewD.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        viewD.layer.shadowOpacity = 0.5;//不透明度
        viewD.layer.shadowRadius = 10.0;//半径
        
        
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
        
        UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent:)];
        UITapGestureRecognizer *tapGestureTel2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent:)];

        //[telephoneLabel addGestureRecognizer:tapGestureTel];
        lblTel.tag = 1;
        lblPhone.tag = 2;
        tapGestureTel.numberOfTouchesRequired = 1; //手指数
        tapGestureTel.numberOfTapsRequired = 1; //tap次数
        tapGestureTel2.numberOfTouchesRequired = 1; //手指数
        tapGestureTel2.numberOfTapsRequired = 1; //tap次数
        lblPhone.userInteractionEnabled = true;
         lblTel.userInteractionEnabled = true;
        [lblPhone addGestureRecognizer:tapGestureTel2];
        
        [lblTel addGestureRecognizer:tapGestureTel];
        
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)teleButtonEvent:(UITapGestureRecognizer*)recognizer
{
    YMUITapGestureRecognizer *tap = (YMUITapGestureRecognizer *)recognizer;
    
    if(recognizer.view.tag == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:member.TelPhone]];
    }
    else if(recognizer.view.tag == 2)
    {
        viewD.hidden = false;
    }
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

- (IBAction)sendPhoneEvent:(id)sender {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:member.Phone]];
}

- (IBAction)sendSMSEvent:(id)sender {
    NSString* sms = [NSString stringWithFormat:@"sms://%@",member.Phone];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:sms]];
}

- (IBAction)canelEvent:(id)sender {
    self.viewD.hidden = true;
}
@end
