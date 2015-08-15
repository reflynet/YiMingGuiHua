//
//  EntityListController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/9.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//




#import "EntityListController.h"

#import "TypeListController.h"
#import "YMItemDeleage.h"
#import "YMChannelItem.h"
#import "YMEntityListController.h"
#import "EntityListController.h"

@implementation EntityListController
@synthesize source;
@synthesize ID;
@synthesize Table;
@synthesize tableVIew;
@synthesize Page;
@synthesize IsLoadedAll;
@synthesize searchContent;
@synthesize txtSearch;


-(IBAction) searchprogram:(id)sender
{
    // if(![txtSearch.text isEqualToString:@""])
    //{
    searchContent = txtSearch.text;
    [self doneLoadingTableViewData];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchContent =@"";
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(searchprogram:)];
    barbtn.title =@"搜索";
    self.navigationItem.rightBarButtonItem = barbtn;
    
    
    
    self.source = [[NSMutableArray alloc]init];
    self.Page=1;
    self.IsLoadedAll = false;
    if(_loadMoreTableFooterView == nil)
    {
        
        
        LoadMoreTableFooterView  *view = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, self.tableVIew.bounds.size.height, self.tableVIew.bounds.size.width, self.tableVIew.bounds.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        view.delegate = self;
        [self.tableVIew addSubview:view];
        _loadMoreTableFooterView = view;
        self.tableVIew.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        //    [view release];
    }
    
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableVIew.bounds.size.height, self.view.frame.size.width, self.tableVIew.bounds.size.height)];
        view.delegate = self;
        [self.tableVIew addSubview:view];
        _refreshHeaderView = view;
        
    }
    
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    
    
    self.automaticallyAdjustsScrollViewInsets =false;
    
    self.navigationController.navigationBarHidden = false;
    
    
    
    tableVIew.rowHeight =80;
    
    UINib *nib = [UINib nibWithNibName:@"YMEntityListController" bundle:nil];
    
    [tableVIew registerNib:nib forCellReuseIdentifier:@"EntityListIdentifier"];
    
    
    //[self doneLoadingTableViewData];
    [self showLoading:self.tableVIew];
    
}

- (void)showLoading:(UIScrollView *)scrollView{
    //下拉刷新
   // [self->_refreshHeaderView setState:EGOOPullRefreshLoading];
    
    [_refreshHeaderView setState:EGOOPullLoading];
    [scrollView setContentOffset:CGPointMake(-0.0f, -60.0f)];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
    [self doneLoadingTableViewData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    EntityListController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EntityList"];
    // [self presentViewController:ickImageViewController animated:YES completion:nil];
    
    [self.navigationController pushViewController:controller animated:true];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if(self.source == nil)
    {
        return  0;
    }
    else{
        return  [self.source count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMChannelItem* current = [ self.source objectAtIndex:indexPath.row];
    
    YMEntityListController *cell = [tableView dequeueReusableCellWithIdentifier:@"EntityListIdentifier" forIndexPath:indexPath];
    
    //  cell.lblTitle.layer.frame.size =
    [cell.lblTitle.layer setFrame: CGRectMake(10.f,3.f,cell.layer.frame.size.width-40,50)];
    cell.lblTitle.numberOfLines =0;
    [cell.lblTime.layer setFrame: CGRectMake(10.f,55.f,cell.layer.frame.size.width,20)];
    //[cell.lblTitle sizeToFit];
    cell.lblTitle.text = current.Title;
    cell.lblTime.text = current.InputTime;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    return  cell;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)layoutSubviews
{
    CGFloat visibleTableDiffBoundsHeight = (self.tableVIew.bounds.size.height - MIN(self.tableVIew.bounds.size.height, self.tableVIew.contentSize.height));
    
    CGRect loadMoreFrame = _loadMoreTableFooterView.frame;
    loadMoreFrame.origin.y = self.tableVIew.contentSize.height + visibleTableDiffBoundsHeight;
    _loadMoreTableFooterView.frame = loadMoreFrame;
    
    
    
    
}

//加载数据

- (void)doneLoadingTableViewData{
    self.IsLoadedAll = false;
    self.Page =1 ;
    YMItemDeleage *delete = [[YMItemDeleage alloc]init];
    [delete getData:self.ID page:self.Page key:self.searchContent m:self.Table Att:@"internal" compete:^(NSMutableArray *arr) {
        
        [self.source removeAllObjects];
        [self.source addObjectsFromArray:arr];
       
        [self.tableVIew reloadData];
        [self layoutSubviews];
      
         if([arr count] <10)
        {
            [_loadMoreTableFooterView setState:EGOPullLoaded];
            self.IsLoadedAll = true;
        }
        
        
    } ];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableVIew];
    [_loadMoreTableFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableVIew];
    
    
}

- (void)moreLoadingTableViewData{
    
    self.Page = self.Page+1;
    YMItemDeleage *delete = [[YMItemDeleage alloc]init];
    [delete getData:self.ID page:self.Page key:@"" m:self.Table Att:@"internal" compete:^(NSMutableArray *arr) {
        
        
        [self.source addObjectsFromArray:arr];
        
        [self.tableVIew reloadData];
        //[self.tableVIew insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
        [self layoutSubviews];
        
        if([arr count] <10)
        {
            [_loadMoreTableFooterView setState:EGOPullLoaded];
            self.IsLoadedAll = true;
        }
        
        
    }];
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableVIew];
    [_loadMoreTableFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableVIew];
    
    
}



#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if(!self.IsLoadedAll)
    {
        [_loadMoreTableFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    if(!self.IsLoadedAll)
    {
        [_loadMoreTableFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
    
}



- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}



- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}


#pragma mark -
#pragma mark LoadMoreTableFooterDelegate Methods

- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view {
    
    
    [self performSelector:@selector(moreLoadingTableViewData) withObject:nil afterDelay:3.0];
    
    
    
}

- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view {
    
    if(!self.IsLoadedAll)
    {
        
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
        
    }
    return _reloading;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    
    return YES;
}



@end
