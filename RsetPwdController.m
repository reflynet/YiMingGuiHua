//
//  RsetPwdController.m
//  yiming
//
//  Created by weiwei wei on 15/8/17.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "RsetPwdController.h"
#import <AFNetworking.h>
#import "YMCommon.h"
@interface RsetPwdController ()

@end

@implementation RsetPwdController
@synthesize txtPwd;
@synthesize txtOldPwd;
@synthesize txtRepwd;
- (void)viewDidLoad {
    [super viewDidLoad];
    [txtOldPwd setSecureTextEntry:YES];
    [txtPwd setSecureTextEntry:YES];
    [txtRepwd setSecureTextEntry:YES];

    
    self.navigationItem.title =@"修改密码";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePwd:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    NSInteger* _id  =  [userDefaults integerForKey:@"ym_customer_id"];

    NSString* rePwd = txtRepwd.text;
    NSString* pwd = txtPwd.text;
    NSString* oldPwd = txtOldPwd.text;
    if([oldPwd isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入旧密码" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"知道了"];
        [alert show];
    }
    else if([txtPwd.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入密码" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"知道了"];
        [alert show];
    }
    else if(![pwd isEqualToString:rePwd])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"两次密码不相同" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"知道了"];
        [alert show];

    }
    else
    {
        NSString* content= [NSString stringWithFormat:@"<item><uid>%d</uid><newpwd>%@</newpwd><oldpwd>%@</oldpwd></item>",_id,pwd,rePwd];
        
        NSString* requestUrl = [[YMCommon getServer] stringByAppendingString: @"client/?c=member&a=change_pwd" ];
        
        NSURL* url =[NSURL URLWithString:requestUrl];
        
        NSMutableURLRequest *request =
        [[NSMutableURLRequest alloc] initWithURL:url];
        
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"text/xml; charset=utf8" forHTTPHeaderField:@"Contsetent-Type"];
        [request setHTTPBody:[YMCommon getDataFromString:content]];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
        [manager setResponseSerializer:responseSer];
        
        
        NSOperation *operation =
        [manager HTTPRequestOperationWithRequest:request
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             NSXMLParser * parser = (NSXMLParser *)responseObject;
                                            // result = nil;
                                             parser.delegate =self;
                                             
                                             [parser setShouldProcessNamespaces:YES];
                                             [parser parse];
                                             
                                             
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             // 失败后的处理
                                             NSLog(error.description);
                                         }];
        [manager.operationQueue addOperation:operation];

    }
    
}
@end
