//
//  TypeListController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/8.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "TypeListController.h"
#import "YMProfileDeleage.h"
#import "YMProfileEntity.h"
#import "YMTypeListCell.h"
#import "EntityListController.h"
#import "MRProgress.h"
#import "YMCommon.h"
@interface TypeListController()
{
    
}

@end


@implementation TypeListController
@synthesize source;
@synthesize ID;
@synthesize tableView;

- (void)viewDidLoad {
   

    MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"加载中...";

    
    
    self.automaticallyAdjustsScrollViewInsets =false;
    self.navigationController.navigationBarHidden = false;
    
    
    YMProfileDeleage *delete = [[YMProfileDeleage alloc]init];
    
    //tableView.rowHeight = 65;
    
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    
    [delete getData:self.ID compete:^(NSMutableArray *arr) {
        
        self.source = arr;
        
        [self.tableView reloadData];
           [progress dismiss:true];
    }];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; 
    [super viewDidLoad];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMProfileEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    EntityListController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EntityList"];
    controller.ID = current.Id;
    controller.Table = current.Table;
    
    [YMCommon setBackBtn:self.navigationItem];
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
    YMProfileEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.lblTitle.text = current.CateName;
    
    
    return  cell;
}





@end
