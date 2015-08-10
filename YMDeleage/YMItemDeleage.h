//
//  YMItemDeleage.h
//  yiming
//
//  Created by 叶 楠 on 15/8/9.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YMItemDeleage : NSObject

-(void)getData : (int)ID page:(int)page key:(NSString*)key m:(NSString*)m Att:(NSString*)attr compete:(void (^)(NSMutableArray *arr))compete;

@end