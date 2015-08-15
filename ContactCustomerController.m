//
//  ContactCustomerController.m
//  yiming
//
//  Created by weiwei wei on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ContactCustomerController.h"
#import "YMContactCustomerDeleteage.h"
#import "YMContactCustomerEntity.h"
#import "YMTypeListCell.h"
#import "MemberController.h"
#import "YMCommon.h"
@implementation ContactCustomerController
@synthesize ID;
@synthesize source;



@synthesize tableView;

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets =false;
    self.navigationController.navigationBarHidden = false;
    self.tableView.dataSource =self;
    self.tableView.delegate = self;

    YMContactCustomerDeleteage *delete = [[YMContactCustomerDeleteage alloc]init];
    
    tableView.rowHeight = 65;
    
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    
    [delete getData:self.ID compete:^(NSMutableArray *arr) {
        
        self.source = arr;
        
        [self.tableView reloadData];
    }];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [super viewDidLoad];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [YMCommon setBackBtn:self.navigationItem];
    YMContactCustomerEntity* current = [ self.source objectAtIndex:indexPath.row];
  
    MemberController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"member"];
    controller.member =current;
    [self.navigationController pushViewController:controller animated:true];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return  [self.source count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMContactCustomerEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
    
    cell.lblTitle.text = current.RealName;
    
    return  cell;
}


@end
