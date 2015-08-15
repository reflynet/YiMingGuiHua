//
//  MemberController.h
//  yiming
//
//  Created by 叶 楠 on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMContactCustomerEntity.h"
@interface MemberController : UIViewController

@property  YMContactCustomerEntity *member;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lblRealName;
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblMail;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
