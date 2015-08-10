//
//  ProjectContrller.h
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface ProjectContrller : UIViewController<PassValueDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewCity;
@property int ID;
@end
