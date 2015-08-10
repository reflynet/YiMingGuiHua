//
//  YMProfileEntity.h
//  yiming
//
//  Created by 叶 楠 on 15/8/4.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YMProfileEntity : NSObject<NSCoding>

@property  int Id;
@property int ModelId;
@property   int ParentId;
@property   NSString* CateName;
@property    NSString* Image;
@property   NSString* Table;
@property NSString* Expand;


@end