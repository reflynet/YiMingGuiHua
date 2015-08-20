//
//  FileDetailViewController.h
//  yiming
//
//  Created by 攒钱网 on 15/8/18.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIWebView *lblContent;





@property int ID;
@property NSString* Table;
@end
