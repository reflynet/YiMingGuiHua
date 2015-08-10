//
//  CityController.h
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@interface CityController : UIViewController
<UITableViewDataSource,UITableViewDelegate>


@property int ID;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;  
@property NSMutableArray* source;



@end
