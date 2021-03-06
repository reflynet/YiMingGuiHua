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
#import "YMContactTableCell.h"
#import "YMContactCustomerEntity.h"
#import "MemberController.h"
#import "MRProgress.h"
#import "YMCommon.h"
#import <ImageLoader/UIImageView+ImageLoader.h>
@implementation LinkManController
@synthesize currentNav;
@synthesize tableView;
@synthesize data;
@synthesize keys;
@synthesize currentNavItem;
@synthesize orgdata;
-(void)loadView
{
    [super loadView];
    self.navigationItem.title =@"用户资料";
    MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"加载中...";
    self.tableView.sectionIndexColor = [UIColor blueColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80.f;
    
    UINib *nib = [UINib nibWithNibName:@"YMContactTableCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMContactIdntifier"];
    
    keys = [[NSMutableArray alloc]init];
    
    
    YMContactDeleage* del = [[YMContactDeleage alloc]init];
    [del getData:^(NSMutableArray *arr) {
        
        orgdata = [del convertToDictionaryByResult:arr];
        
        
        [self resetData :@""];
        [progress dismiss:true];
        
    }];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [tableView setContentInset:tableView.contentInset];
    self.searchBar.delegate = self;
    
    
    
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
    
    YMContactTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMContactIdntifier" forIndexPath:indexPath];
    
    NSString* key = self.keys[ indexPath.section];
    NSMutableArray* dataSection = self.data[key];
    YMContactEntity *entity =  dataSection[indexPath.row];
    cell.lblTitle.text = entity.RealName;
    cell.lblDesc.text = [NSString stringWithFormat:@"%@/%@",entity.Job,entity.Department];
    NSString* image =  [[YMCommon getServer] stringByAppendingString: entity.FacePhoto ];
    
    cell.imgAvatar.layer.cornerRadius = cell.imgAvatar.frame.size.width / 2;
    cell.imgAvatar.clipsToBounds = YES;
    cell.imgAvatar.layer.borderWidth = 1.0f;
    cell.imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [cell.imgAvatar setImageWithURL:[NSURL URLWithString:image]];
    
    
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
    member.TelPhone = entity.TelPhone;
    member.Phone = entity.Phone;
    [YMCommon setBackBtn:self.currentNavItem];
    MemberController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"member"];
    controller.member =member;
    [self.currentNav pushViewController:controller animated:true];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    [self resetData:searchText];
    
}

-(void)resetData:(NSString*) key
{
    data = [[NSMutableDictionary alloc]init];
    keys = [[NSMutableArray alloc]init];
    
    NSEnumerator * enumeratorKey = [orgdata keyEnumerator];
    
    //快速枚举遍历所有KEY的值
    for (NSObject *object in enumeratorKey) {
        
        [data setObject:[[NSMutableArray alloc]init] forKey:object];
        
        for (int i =0 ;i<[orgdata[object] count];i++) {
            YMContactEntity* _t =orgdata[object][i];
 
            if ([key isEqualToString:@""] ||[_t.RealName rangeOfString:key].location != NSNotFound)
           {
                [data[object] addObject:_t];
           }
        }
        if([data[object] count]>0)
        {
            [keys addObject:object];

        }
        
    }
    
    
    
    [keys sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    
    [self.tableView reloadData];
    
}



@end
