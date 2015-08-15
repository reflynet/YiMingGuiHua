//
//  LinkManController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "LinkManController.h"
#import "YMContactDeleage.h"
#import "YMContactEntity.h"
#import "YMTypeListCell.h"
#import "YMContactCustomerEntity.h"
#import "MemberController.h"
#import "MRProgress.h"
#import "YMCommon.h"
@implementation LinkManController
@synthesize currentNav;
@synthesize tableView;
@synthesize data;
@synthesize keys;
@synthesize currentNavItem;
-(void)loadView
{
    [super loadView];
  
    MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"加载中...";

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    
    keys = [[NSMutableArray alloc]init];
    
    
    YMContactDeleage* del = [[YMContactDeleage alloc]init];
    [del getData:^(NSMutableArray *arr) {
        data = [del convertToDictionaryByResult:arr];
        [progress dismiss:true];
        NSEnumerator * enumeratorKey = [data keyEnumerator];
        
        //快速枚举遍历所有KEY的值
        for (NSObject *object in enumeratorKey) {
            [keys addObject:object];
        }
        [keys sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
            NSString *str1=(NSString *)obj1;
            NSString *str2=(NSString *)obj2;
            return [str1 compare:str2];
        }];
        
        [self.tableView reloadData];
        
    }];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [tableView setContentInset:tableView.contentInset];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.keys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = self.keys[section];
    NSMutableArray *nameSction = self.data[key];
    return [nameSction count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
    
    NSString* key = self.keys[ indexPath.section];
    NSMutableArray* dataSection = self.data[key];
    YMContactEntity *entity =  dataSection[indexPath.row];
    cell.lblTitle.text = entity.RealName;
    
    return  cell;
    
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  self.keys;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* key = self.keys[ indexPath.section];
    NSMutableArray* dataSection = self.data[key];
    YMContactEntity *entity =  dataSection[indexPath.row];
    
    YMContactCustomerEntity* member = [[YMContactCustomerEntity alloc]init];
    member.ID = entity.Id;
    member.RealName = entity.RealName;
    member.FacePhoto = entity.FacePhoto;
    member.Email = entity.Email;
    member.Job = entity.Job;
    member.Department = entity.Department;
    
        [YMCommon setBackBtn:self.currentNavItem];
    MemberController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"member"];
    controller.member =member;
    [self.currentNav pushViewController:controller animated:true];
    
}


@end
