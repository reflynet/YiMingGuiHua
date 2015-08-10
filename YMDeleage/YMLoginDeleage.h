//
//  YMLoginDeleage.h
//  yiming
//
//  Created by 叶 楠 on 15/8/4.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "YMCustomerEntity.h"

@interface YMLoginDeleage : NSObject

@property YMCustomerEntity* result;

-(void)login:(NSString *) userName
pwd:(NSString *) pwd
    compete :(void (^)(YMCustomerEntity*))compete;

@end