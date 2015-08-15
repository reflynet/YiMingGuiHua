//
//  YMCommon.h
//  yiming
//
//  Created by 叶 楠 on 15/8/3.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface YMCommon : NSObject

+(NSString*) getServer;
+(NSData*) getDataFromString:(NSString*) str;
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+(UIColor *)getColor:(NSString*)hexColor;
+(void)setBackBtn:(UINavigationItem*) nav;
@end