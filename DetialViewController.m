//
//  DetialViewController.m
//  yiming
//
//  Created by 攒钱网 on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "DetialViewController.h"
#import "YMDetailDelegate.h"
#import "YMEntityDetail.h"
#import "YMReadUser.h"
#import "YMReadUserDelegate.h"
@interface DetialViewController ()

@end

@implementation DetialViewController
@synthesize ID;
@synthesize Table;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewRead.hidden = TRUE;
    
       YMDetailDelegate*  detailDelegate = [[YMDetailDelegate alloc]init];
    [detailDelegate getData:ID m:Table compete:^(YMEntityDetail* arr) {
        self.lblName.text = arr.Juanzong;
        self.lblBianhao.text = arr.Wenjianbianhao;
        self.lblDanwei.text= arr.Fawendanwei;
        self.lblShijian.text= arr.Fawenshijian;
        self.lblWenjianbiaoti.text= arr.Wenjianbiaoti;
        self.lblBaomidengji.text=arr.Baomidengji;
        self.lblDengjihao.text=arr.Dengjihao;
        self.lblNibanyijian.text=arr.Nibanyijian;
 
        
        [self.lblWeb loadHTMLString:arr.Content baseURL:nil];
    }];
    
    
    
    YMReadUserDelegate* readuserDelegate = [[YMReadUserDelegate alloc]init];
    [readuserDelegate getData:ID compete:^(NSMutableArray *arr) {
    
        NSString* users= [[NSString alloc] init];
       for(YMReadUser* user in arr)
       {
            users =[users stringByAppendingString:user.username];
           users =[users stringByAppendingString:@" "];
           
           
           NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
           
           //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
           NSString* truename  =  [userDefaults valueForKey:@"ym_customer_truename"];
           if([truename isEqualToString:user.username])
           {
               self.viewRead.hidden = FALSE;
           }
       }
    
        self.lblYiyuerenyuan.text = users;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
