//
//  YMProfileDeleage.h
//  yiming
//
//  Created by 叶 楠 on 15/8/3.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface YMProfileDeleage : NSObject

-(void)getData : (int)ID compete:(void (^)(NSMutableArray *arr))compete;

@end 