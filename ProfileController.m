//
//  ProfileController.m
//  yiming
//
//  Created by 叶 楠 on 15/8/4.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ProfileController.h"
#import "MRProgress.h"
#import "YMCommon.h"
#import "YMProfileDeleage.h"
#import "YMProfileEntity.h"
#import "TypeListController.h"
#import "YMUITapGestureRecognizer.h"
#import <ImageLoader/UIImageView+ImageLoader.h>
#import "ContactController.h"
@interface ProfileController()
@property NSString* image ;
@property MRProgressOverlayView* progress ;
@property int currentSelectID;

@property NSArray *arrary ;

@end

@implementation ProfileController


@synthesize arrary;
@synthesize  progress;
@synthesize viewProfile;
@synthesize image;
@synthesize lblJob;
@synthesize lblName;
@synthesize imgAvatar;
@synthesize currentSelectID;

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    arrary = [[NSArray alloc]initWithObjects:[YMCommon hexStringToColor:@"CF0001"],[YMCommon hexStringToColor:@"71aa00" ],[YMCommon hexStringToColor:@"f2931b" ],[YMCommon hexStringToColor: @"00b7ee" ], nil];
    
    progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"加载中...";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    NSString* truename  =  [userDefaults valueForKey:@"ym_customer_truename"];
    
    NSString* job  =  [userDefaults valueForKey:@"ym_customer_job"];
    
    NSString* grade  =  [userDefaults valueForKey:@"ym_customer_xmpp"];
    
    image  =  [userDefaults valueForKey:@"ym_customer_img"];
    
    image =  [[YMCommon getServer] stringByAppendingString: image ];
    
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width / 2;
    self.imgAvatar.clipsToBounds = YES;
    self.imgAvatar.layer.borderWidth = 1.0f;
    self.imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.imgAvatar setImageWithURL:[NSURL URLWithString:image]];
    
    self.lblName.text =truename;
    
    self.lblJob.text=grade ;
    
    [self loadUI];
    
    
    
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    YMUITapGestureRecognizer *tap = (YMUITapGestureRecognizer *)recognizer;
    [YMCommon setBackBtn:self.navigationItem];
    if([tap.Expend isEqualToString:@"address"])
    {
        ContactController *ickImageViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
        // [self presentViewController:ickImageViewController animated:YES completion:nil];
        //  ickImageViewController.ID = recognizer.view.tag;
        [self.navigationController pushViewController:ickImageViewController animated:true];
    }
    else
    {
        
        if([tap.Table isEqualToString:@"project"])
        {
            TypeListController *ickImageViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:@"project"];
            // [self presentViewController:ickImageViewController animated:YES completion:nil];
            ickImageViewController.ID = recognizer.view.tag;
            
            
            [self.navigationController pushViewController:ickImageViewController animated:true];
        }
        else
        {
            TypeListController *ickImageViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:@"typelist"];
            // [self presentViewController:ickImageViewController animated:YES completion:nil];
            ickImageViewController.ID = recognizer.view.tag;
            
            
            
            [self.navigationController pushViewController:ickImageViewController animated:true];
        }
    }
    
}



-(void)loadUI
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray* profile  =  [userDefaults valueForKey:@"ym_profile"];
    
    CGRect r = [ UIScreen mainScreen ].applicationFrame;
    //计算空隙
    CGFloat sp =r.size.width*0.04f ;
    //计算宽度
    CGFloat spWidth =( r.size.width - (sp * 3 ))/2;
    
    //计算图片位置
    CGFloat spImageWidth = spWidth * 0.5f;
    CGFloat spImageX = (spWidth -spImageWidth)/2.0f;
    
    
    YMProfileDeleage*  ymProfileDeleage = [[YMProfileDeleage alloc]init];
    [ymProfileDeleage getData :0 compete:^(NSMutableArray* arr){
        [progress dismiss:true];
        if (arr != nil) {
            for (int i = 0; i<arr.count; i++) {
                
                int yushu = i % 4;
                
                YMProfileEntity* entity = [arr objectAtIndex:i];
                
                UIView* view = [[UIView alloc]init];
                UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(0.0f,spImageWidth+35.f, spWidth,20.0f)];
                
                CGFloat spImageY = (spWidth -(spImageWidth+35))/2.0f;
                
                lable.text = entity.CateName;
                lable.adjustsFontSizeToFitWidth =true;
                lable.textAlignment =NSTextAlignmentCenter;
                lable.textColor =[UIColor whiteColor];
                [lable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
                
                view.frame = CGRectMake((i%2)*(spWidth+sp)+sp, (i/2)*(spWidth+sp)+sp, spWidth, spWidth);
                
                
                UIColor *testColor1=[YMCommon hexStringToColor:@"#fff"];
                [view setBackgroundColor:arrary[yushu]];
                
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(spImageX,spImageY ,spImageWidth, spImageWidth)];
                
                
                
                NSString* imageUrl = [[YMCommon getServer] stringByAppendingString: entity.Image ];
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 5.0;
                view.layer.borderWidth = 1.0;
                view.layer.borderColor = [arrary[yushu] CGColor];
                view.userInteractionEnabled = YES;
                [image setImageWithURL:[NSURL URLWithString:imageUrl]];
                [view addSubview:image];
                [view addSubview:lable];
                [self.viewProfile addSubview:view];
                
                
                YMUITapGestureRecognizer* singleRecognizer; singleRecognizer =
                [[YMUITapGestureRecognizer alloc]initWithTarget:(self) action:@selector(SingleTap:)];
                
                
                view.tag = entity.Id;
                singleRecognizer.Expend = entity.Expand;
                singleRecognizer.Table = entity.Table;
                singleRecognizer.numberOfTouchesRequired = 1; //手指数
                singleRecognizer.numberOfTapsRequired = 1; //tap次数
                
                [view addGestureRecognizer:singleRecognizer];
                
            }
        }
        
        
    }];
    
    
}


@end
