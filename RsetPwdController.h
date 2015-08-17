//
//  RsetPwdController.h
//  yiming
//
//  Created by weiwei wei on 15/8/17.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RsetPwdController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtRepwd;
@property (weak, nonatomic) IBOutlet UIButton *btnChanage;
- (IBAction)changePwd:(id)sender;

@end
