//
//  YMContactCustomerDeleteage.h
//  yiming
//
//  Created by weiwei wei on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMContactCustomerDeleteage : NSObject
-(void)getData : (int)ID compete:(void (^)(NSMutableArray *arr))compete;
@end
