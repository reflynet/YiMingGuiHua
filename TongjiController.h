//
//  TongjiController.h
//  yiming
//
//  Created by weiwei wei on 15/8/17.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TongjiController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblA1;
@property (weak, nonatomic) IBOutlet UILabel *lblA2;
@property (weak, nonatomic) IBOutlet UILabel *lblA3;
@property (weak, nonatomic) IBOutlet UILabel *lblA4;
@property (weak, nonatomic) IBOutlet UILabel *B;
@property (weak, nonatomic) IBOutlet UILabel *B2;
@property (weak, nonatomic) IBOutlet UILabel *lblB3;
@property (weak, nonatomic) IBOutlet UILabel *lblB4;

@property (weak) NSString* currentElement;

@end
