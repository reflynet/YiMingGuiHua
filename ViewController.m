//
//  ViewController.m
//  yiming
//
//  Created by 叶 楠 on 15/7/26.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize btnLogin;
@synthesize viewBackground;
@synthesize imageLogo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setLayout
{
    viewBackground.layer.masksToBounds = YES;
    viewBackground.layer.cornerRadius = 3.0;
    viewBackground.layer.borderWidth = 1.0;
    viewBackground.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 3.0;
    btnLogin.layer.borderWidth = 1.0;
    btnLogin.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    CGFloat imageWidth =imageLogo.frame.size.width;
    CGSize imagesize=CGSizeMake(imageWidth,imageWidth);
    

}

@end
