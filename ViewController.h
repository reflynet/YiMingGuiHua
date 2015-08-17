//
//  ViewController.h
//  yiming
//
//  Created by 叶 楠 on 15/7/26.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileController.h"
#import "YMProfileDeleage.h"
#import "YMLoginDeleage.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIView *viewBackground;
@property (strong, nonatomic) IBOutlet UIImageView *imageLogo;
@property (strong, nonatomic) IBOutlet UIView *viewBg;

@property (nonatomic, strong)  YMProfileDeleage* ymProfileDeleage;
@property (nonatomic, strong)  YMLoginDeleage* ymLoginDeleage;

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

@property (strong, nonatomic) ViewController *loginController;
@property (weak, nonatomic) IBOutlet UIImageView *cbRe;
@property BOOL Remeber;
- (IBAction)onLogin:(id)sender;

@end

