//
//  TypeListController.h
//  yiming
//
//  Created by 叶 楠 on 15/8/8.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeListController : UIViewController
<UITableViewDataSource,UITableViewDelegate>


@property int ID;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray* source;



@end
