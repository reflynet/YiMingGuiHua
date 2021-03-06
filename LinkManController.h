//
//  LinkManController.h
//  yiming
//
//  Created by 叶 楠 on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkManController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property   NSMutableDictionary* orgdata;
@property   NSMutableDictionary* data;
@property NSMutableArray *keys;
@property UINavigationController* currentNav;
@property UINavigationItem* currentNavItem;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
