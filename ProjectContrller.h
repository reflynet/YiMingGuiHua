//
//  ProjectContrller.h
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface ProjectContrller : UITableViewController<PassValueDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *cellCity;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellPro;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDDD;
@property (weak, nonatomic) IBOutlet UIView *viewCity;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellSearch;
@property int ID;
@end
