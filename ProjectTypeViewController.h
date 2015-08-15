//
//  ProjectTypeViewController.h
//  yiming
//
//  Created by 叶 楠 on 15/8/16.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@interface ProjectTypeViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;
@end
