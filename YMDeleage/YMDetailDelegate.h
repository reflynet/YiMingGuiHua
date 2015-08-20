//
//  YMDetailDelegate.h
//  yiming
//
//  Created by 攒钱网 on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMEntityDetail.h"
@interface YMDetailDelegate : NSObject
-(void)getData : (int)entityid m:(NSString*)m compete:(void (^)(YMEntityDetail* arr))compete;
@end
