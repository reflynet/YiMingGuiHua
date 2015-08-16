//
//  YMContactTableCell.h
//  yiming
//
//  Created by weiwei wei on 15/8/16.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMContactTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@end
