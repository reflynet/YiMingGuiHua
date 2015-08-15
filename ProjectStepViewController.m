//
//  ProjectStepViewController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/16.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ProjectStepViewController.h"
#import "YMTypeListCell.h"
@interface ProjectStepViewController ()

@end

@implementation ProjectStepViewController
@synthesize tableView;
@synthesize source;
@synthesize delegate;

- (void)viewDidLoad {
    source = [[NSMutableArray alloc]init];
    [source addObject:@"A类工程计划"];
     [source addObject:@"B类工程计划"];
     [source addObject:@"C类工程计划"];
     [source addObject:@"D类工程计划"];
    
    UIEdgeInsets contentInsets = tableView.contentInset;
    contentInsets.top = 20;
    [tableView setContentInset:contentInsets];
    
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"YMTypeListCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"YMTypeListIdentifiter"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMTypeListIdentifiter" forIndexPath:indexPath];
     NSString* current = [ self.source objectAtIndex:indexPath.row];
    cell.lblTitle.text = current;
    cell.accessoryType =UITableViewCellAccessoryCheckmark;

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* current = [ self.source objectAtIndex:indexPath.row];
    
    [self dismissViewControllerAnimated:true completion:^{
          [self.delegate passValue:3 value:current];
    }];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
