//
//  ViewController.h
//  yiming
//
//  Created by 叶 楠 on 15/7/26.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIView *viewBackground;
@property (strong, nonatomic) IBOutlet UIImageView *imageLogo;
@property (strong, nonatomic) IBOutlet UIView *viewBg;

@property (strong, nonatomic) ViewController *loginController;
- (IBAction)onLogin:(id)sender;

@end

