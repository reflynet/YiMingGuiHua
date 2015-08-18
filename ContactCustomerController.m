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
#import "YMContactTableCell.h"
#import "MemberController.h"
#import "YMCommon.h"
#import <ImageLoader/UIImageView+ImageLoader.h>
@implementation ContactCustomerController
@synthesize ID;
@synthesize source;



@synthesize tableView;

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets =false;
    self.navigationController.navigationBarHidden = false;
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
self.navigationItem.title =@"联系人";
    YMContactCustomerDeleteage *delete = [[YMContactCustomerDeleteage alloc]init];
    
    tableView.rowHeight = 80.f;
    
    UINib *nib = [UINib nibWithNibName:@"YMContactTableCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMContactIdntifier"];
    
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
    
    YMContactTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMContactIdntifier" forIndexPath:indexPath];
    
    cell.lblTitle.text = current.RealName;
    cell.lblDesc.text = [NSString stringWithFormat:@"%@/%@",current.Job,current.Department];
    NSString* image =  [[YMCommon getServer] stringByAppendingString: current.FacePhoto ];
    
    cell.imgAvatar.layer.cornerRadius = cell.imgAvatar.frame.size.width / 2;
    cell.imgAvatar.clipsToBounds = YES;
    cell.imgAvatar.layer.borderWidth = 1.0f;
    cell.imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [cell.imgAvatar setImageWithURL:[NSURL URLWithString:image]];
    return  cell;
}


@end
