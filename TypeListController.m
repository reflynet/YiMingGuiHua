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

@interface TypeListController()
{
    
}

@end


@implementation TypeListController
@synthesize source;
@synthesize ID;
@synthesize tableView;

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets =false;
    self.navigationController.navigationBarHidden = false;
    
    
    YMProfileDeleage *delete = [[YMProfileDeleage alloc]init];
    
    tableView.rowHeight = 65;
    
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    
    [delete getData:self.ID compete:^(NSMutableArray *arr) {
        
        self.source = arr;
        
        [self.tableView reloadData];
    }];
    
    [super viewDidLoad];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMProfileEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    EntityListController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EntityList"];
    controller.ID = current.Id;
    controller.Table = current.Table;
    [self.navigationController pushViewController:controller animated:true];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return  [self.source count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMProfileEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
    
    cell.lblTitle.text = current.CateName;
    
    return  cell;
}





@end
