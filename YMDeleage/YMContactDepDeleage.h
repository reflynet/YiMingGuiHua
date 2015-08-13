//
//  YMContactDepDeleage.h
//  yiming
//
//  Created by 叶 楠 on 15/8/12.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMContactDepDeleage : NSObject
-(void)getData :(int)type compete:(void (^)(NSMutableArray *arr))compete;
-(NSMutableDictionary*)convertToDictionaryByResult: (NSMutableArray*) arr;
@end
