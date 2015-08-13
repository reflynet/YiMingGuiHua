//
//  ContactCustomerController.h
//  yiming
//
//  Created by weiwei wei on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMContactCustomerEntity.h"
@interface ContactCustomerController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property YMContactCustomerEntity* member;

@property int ID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray* source;
@end
