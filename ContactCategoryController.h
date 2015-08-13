//
//  ContactCategoryController.h
//  yiming
//
//  Created by 叶 楠 on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCategoryController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property   NSMutableDictionary* data;
@property NSMutableArray *keys;
@property UINavigationController* currentNav;
@end
