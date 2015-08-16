//
//  YMSelectProjectDeleage.h
//  yiming
//
//  Created by 叶 楠 on 15/8/16.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMSelectProjectDeleage : NSObject
-(void)getData : (int)pageSize page:(int)page key:(NSString*)key city:(NSString*)city type:(NSString*)type pStatus:(NSString*)pStatus compete:(void (^)(NSMutableArray *arr))compete;
@end
