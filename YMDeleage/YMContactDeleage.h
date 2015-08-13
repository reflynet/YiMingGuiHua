//
//  YMContactDeleage.h
//  yiming
//
//  Created by 叶 楠 on 15/8/11.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMContactDeleage : NSObject
-(void)getData :(void (^)(NSMutableArray *arr))compete;
-(NSMutableDictionary*)convertToDictionaryByResult: (NSMutableArray*) arr;

@end
