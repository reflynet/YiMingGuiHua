//
//  YMReadUserDelegate.h
//  yiming
//
//  Created by 攒钱网 on 15/8/20.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMReadUserDelegate : NSObject
-(void)getData : (int)entityid compete:(void (^)(NSMutableArray* arr))compete;
@end
