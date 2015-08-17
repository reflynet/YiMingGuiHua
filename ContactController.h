//
//  ContactController.h
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LinkManController.h"
#import "ContactCategoryController.h"
#import "CityController.h"
@interface ContactController : UIViewController

@property ContactCategoryController* _contactController;
@property LinkManController* _linkManContrller;
@property CityController* _city;
@property NSString* Title;
@end
