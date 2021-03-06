//
//  ViewController.m
//  yiming
//
//  Created by 叶 楠 on 15/7/26.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ViewController.h"
#import "GmailLikeLoadingView.h"
#import "YMProfileEntity.h"
#import "MRProgress.h"
#import "YMCommon.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize btnLogin;
@synthesize viewBackground;
@synthesize imageLogo;
@synthesize viewBg;
@synthesize loginController;
@synthesize cbRe;
@synthesize ymProfileDeleage;
@synthesize ymLoginDeleage;
@synthesize Remeber;
@synthesize txtPwd;
@synthesize txtUserName;
-(void)teleButtonEvent:(UITapGestureRecognizer*)recognizer
{
    if(Remeber == YES)
    {
        [cbRe setImage:[UIImage imageNamed:@"checkbox-off"]];
        Remeber = NO;

    }
    else{
        
        [cbRe setImage:[UIImage imageNamed:@"checkbox-on"]];
        Remeber = YES;
        
        
    }
}

- (void)viewDidLoad {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [txtPwd setSecureTextEntry:YES];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    BOOL* rember  =  [userDefaults boolForKey:@"ym_customer_remember"];
    if(rember == YES)
    {
        [cbRe setImage:[UIImage imageNamed:@"checkbox-on"]];
        txtUserName.text =[userDefaults valueForKey:@"ym_customer_remember_u"];
        txtPwd.text =[userDefaults valueForKey:@"ym_customer_remember_P"];
        Remeber = YES;
    }
    else
    {
      [cbRe setImage:[UIImage imageNamed:@"checkbox-off"]];
        Remeber = NO;
    }
    UITapGestureRecognizer *tapGestureTel= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent:)];
    
    //[telephoneLabel addGestureRecognizer:tapGestureTel];

    tapGestureTel.numberOfTouchesRequired = 1; //手指数
    cbRe.userInteractionEnabled = true;
    [cbRe addGestureRecognizer:tapGestureTel];

    self.navigationController.navigationBarHidden = true;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
    [[UINavigationBar appearance] setBarTintColor:[YMCommon hexStringToColor:@"CF0001"]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [super viewDidLoad];
    [self setLayout];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(void) setLayout
{
    viewBackground.layer.masksToBounds = YES;
    viewBackground.layer.cornerRadius = 3.0;
    viewBackground.layer.borderWidth = 1.0;
    viewBackground.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 3.0;
    btnLogin.layer.borderWidth = 1.0;
    btnLogin.layer.borderColor = [[YMCommon hexStringToColor:@"CF0001"] CGColor];
    btnLogin.backgroundColor =[YMCommon hexStringToColor:@"CF0001"];
    CGFloat imageWidth =imageLogo.frame.size.width;
    CGSize imagesize=CGSizeMake(imageWidth,imageWidth);
    
    }

- (IBAction)onLogin:(id)sender {
    
 // [MRProgressOverlayView showOverlayAddedTo:self.window animated:YES];
    MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"登录中...";
    
    
   // progress.mode = MRProgressOverlayViewModeCross;

    
    
    ymLoginDeleage = [[YMLoginDeleage alloc]init];
    
    [ymLoginDeleage login:@"18202812576" pwd:@"123456789" compete:^(YMCustomerEntity* res) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
           [userDefaults setInteger: res.ID forKey:@"ym_customer_id"];
        [userDefaults setValue:res.TrueName forKey:@"ym_customer_truename"];
        [userDefaults setValue:res.Job forKey:@"ym_customer_job"];
                [userDefaults setValue:res.GradeName forKey:@"ym_customer_grade"];
               [userDefaults setValue:res.XmppName forKey:@"ym_customer_xmpp"];
        [userDefaults setValue:res.Img forKey:@"ym_customer_img"];
        
        [userDefaults synchronize];
        
        if(res != nil)
        {
            
            if(Remeber == YES)
            {
            
                 [userDefaults setBool:YES forKey:@"ym_customer_remember"];
                      [userDefaults setValue:@"18202812576" forKey:@"ym_customer_remember_u"];
                      [userDefaults setValue:@"123456789" forKey:@"ym_customer_remember_P"];
            }
            else{
                 [userDefaults setBool:NO forKey:@"ym_customer_remember"];
            }
            
             progress.titleLabelText = @"登录成功,即将登陆系统";
            int64_t delayInSeconds = 1.0;
            progress.mode = MRProgressOverlayViewModeCheckmark;
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                          delayInSeconds * NSEC_PER_SEC);
          
            dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
              
                
                            [progress dismiss:true];
              
            });
            
            
            ProfileController *ickImageViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
           // [self presentViewController:ickImageViewController animated:YES completion:nil];
           [self.navigationController pushViewController:ickImageViewController animated:true];
            
             //self.performSegueWithIdentifier("profile", sender: nil)
            [self removeFromParentViewController];
            [self dismissViewControllerAnimated:true completion:nil];
               //  self.dismissViewControllerAnimated(true, completion: nil)

            
          

        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"登录失败" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            // optional - add more buttons:
            [alert addButtonWithTitle:@"知道了"];
            [alert show];}
        
    }];

}
@end
