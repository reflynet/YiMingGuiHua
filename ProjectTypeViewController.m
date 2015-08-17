//
//  ProjectTypeViewController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/16.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ProjectTypeViewController.h"
#import "YMProfileDeleage.h"
#import "YMProfileEntity.h"
#import "YMTypeListCell.h"
@interface ProjectTypeViewController ()

@property NSMutableArray* source;
@end

@implementation ProjectTypeViewController
@synthesize tableView;
@synthesize source;

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    UIEdgeInsets contentInsets = tableView.contentInset;
    contentInsets.top = 20;
    [tableView setContentInset:contentInsets];
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; 

    YMProfileDeleage* del = [[YMProfileDeleage alloc]init];
    [del getData:116 compete:^(NSMutableArray *arr) {
        self.source = arr;
        [self.tableView reloadData];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.source count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMProfileEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
    
    cell.lblTitle.text = current.CateName;
      cell.accessoryType =UITableViewCellAccessoryCheckmark;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   YMProfileEntity* current = [ self.source objectAtIndex:indexPath.row];
    
    [self dismissViewControllerAnimated:true completion:^{
        [self.delegate passValue:2 value:current.CateName];
    }];
    
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
