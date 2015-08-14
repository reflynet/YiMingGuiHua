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
@interface ViewController ()

@end

@implementation ViewController

@synthesize btnLogin;
@synthesize viewBackground;
@synthesize imageLogo;
@synthesize viewBg;
@synthesize loginController;

@synthesize ymProfileDeleage;
@synthesize ymLoginDeleage;

- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden = true;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [super viewDidLoad];
    
    
    GmailLikeLoadingView *loadingView = [[GmailLikeLoadingView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    
    [viewBg addSubview:loadingView];
    
    [loadingView startAnimating];
    
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
    btnLogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    CGFloat imageWidth =imageLogo.frame.size.width;
    CGSize imagesize=CGSizeMake(imageWidth,imageWidth);
    
    
}

- (IBAction)onLogin:(id)sender {
    
 // [MRProgressOverlayView showOverlayAddedTo:self.window animated:YES];
   MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [UIColor redColor];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"登录中...";
    
    
   // progress.mode = MRProgressOverlayViewModeCross;

    
    
    ymLoginDeleage = [[YMLoginDeleage alloc]init];
    
    [ymLoginDeleage login:@"18202812576" pwd:@"123456789" compete:^(YMCustomerEntity* res) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
        [userDefaults setValue:res.TrueName forKey:@"ym_customer_truename"];
        [userDefaults setValue:res.Job forKey:@"ym_customer_job"];
                [userDefaults setValue:res.GradeName forKey:@"ym_customer_grade"];
               [userDefaults setValue:res.XmppName forKey:@"ym_customer_xmpp"];
        [userDefaults setValue:res.Img forKey:@"ym_customer_img"];
        
        [userDefaults synchronize];
        
        if(res != nil)
        {
            
             progress.titleLabelText = @"登录成功,即将登陆系统";
            int64_t delayInSeconds = 1.0;
            progress.mode = MRProgressOverlayViewModeCheckmark;
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                          delayInSeconds * NSEC_PER_SEC);
          
            dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
                ProfileController *ickImageViewController =
                [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
                [self presentViewController:ickImageViewController animated:YES completion:nil];
                
                [self.navigationController pushViewController:ickImageViewController animated:true];
                [self removeFromParentViewController];
                [progress dismiss:true];
              
            });

            
          

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
