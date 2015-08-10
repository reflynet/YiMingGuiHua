//
//  YMChannelItem.h
//  yiming
//
//  Created by 叶 楠 on 15/8/9.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#ifndef yiming_YMChannelItem_h
#define yiming_YMChannelItem_h


#endif
#import <UIKit/UIKit.h>


@interface YMChannelItem :NSObject

@property int Id; 

@property int Expire;

@property int CateId;

@property (copy,nonatomic)NSString* Template;

@property (copy,nonatomic)NSString* Thumb;

@property (copy,nonatomic)NSString* InputTime;


@property (copy,nonatomic)NSString* Description;

@property (copy,nonatomic)NSString* Title;


@property int Clicks;

@end