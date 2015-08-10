//
//  EntityListController.h
//  yiming
//
//  Created by 叶 楠 on 15/8/9.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#include "LoadMoreTableFooterView.h"
@interface EntityListController : UIViewController<UITableViewDataSource,UITableViewDelegate,
EGORefreshTableHeaderDelegate,LoadMoreTableFooterDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    BOOL _reloading;
    BOOL _loading;

}

@property int Page ;
@property int ID;
@property NSString* Table;
@property BOOL IsLoadedAll;
@property NSMutableArray* source;

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)moreLoadingTableViewData;
@end
