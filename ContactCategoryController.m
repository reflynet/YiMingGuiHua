//
//  LinkManController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ContactCategoryController.h"
#import "YMContactDepDeleage.h"
#import "YMContactDepEntity.h"
#import "YMTypeListCell.h"
#import "ContactCustomerController.h"
@interface ContactCategoryController()
@property BOOL isSelect;

@end


@implementation ContactCategoryController
@synthesize currentNav;
@synthesize isSelect;
@synthesize tableView;
@synthesize data;
@synthesize keys;

-(void)loadView
{
    [super loadView];
    self.isSelect =false;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    
    keys = [[NSMutableArray alloc]init];
    
    
    YMContactDepDeleage* del = [[YMContactDepDeleage alloc]init];
    [del getData:0 compete:^(NSMutableArray *arr) {
        
        data = [del convertToDictionaryByResult:arr];
        
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
    
    //[tableView setContentInset:tableView.contentInset];
    
    
    
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
    YMContactDepEntity *entity =  dataSection[indexPath.row];
    cell.lblTitle.text = entity.Name;
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* key = self.keys[ indexPath.section];
    NSMutableArray* dataSection = self.data[key];
    YMContactDepEntity *entity =  dataSection[indexPath.row];
    if(self.isSelect == false)
    {
        keys = [[NSMutableArray alloc]init];
        
        
        YMContactDepDeleage* del = [[YMContactDepDeleage alloc]init];
        [del getData:entity.ID compete:^(NSMutableArray *arr) {
            
            data = [del convertToDictionaryByResult:arr];
            
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
            self.isSelect =true;
            [self.tableView reloadData];
            
        }];
    }
    else{
        ContactCustomerController* nextC =
        [self.storyboard instantiateViewControllerWithIdentifier:@"ContactCustomer"];
        nextC.ID = entity.ID;
        [self.currentNav pushViewController:nextC animated:true];
        
        
    }
    
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  self.keys;
}

@end
