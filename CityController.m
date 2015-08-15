//
//  CityController.m
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "CityController.h"

#import "YMCityDeleage.h"
#import "YMCityEntity.h"
#import "YMTypeListCell.h"
#import "EntityListController.h"


@interface CityController ()

@end

@implementation CityController

@synthesize source;
@synthesize ID;
@synthesize tableView;
@synthesize delegate;

- (void)viewDidLoad {
    
    UIEdgeInsets contentInsets = tableView.contentInset;
    contentInsets.top = 20;
    [tableView setContentInset:contentInsets];
    self.automaticallyAdjustsScrollViewInsets =false;
    self.navigationController.navigationBarHidden = false;
    tableView.dataSource = self;
    tableView.delegate =self;
     YMCityDeleage *delete = [[YMCityDeleage alloc]init];
    
    //tableView.rowHeight = 65;
    
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    
    [delete getData :^(NSMutableArray *arr) {
        
        self.source = arr;
        
        [self.tableView reloadData];
    }];
    
    [super viewDidLoad];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMCityEntity* current = [ self.source objectAtIndex:indexPath.row];
    
  
    [self dismissViewControllerAnimated:true completion:^{
         [self.delegate passValue:1 value:current.Name];
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return  [self.source count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMCityEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
    
    cell.lblTitle.text = current.Name;
    cell.accessoryType= UITableViewCellAccessoryCheckmark;
    return  cell;
}
@end
