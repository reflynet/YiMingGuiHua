//
//  YMContactEntity.h
//  yiming
//
//  Created by 叶 楠 on 15/8/11.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMContactEntity : NSObject
@property int Id;

@property int GroupID;

@property int AreaID;

@property NSString* FacePhoto;

@property NSString* UserName;

@property NSString* XmppName;

@property NSString* Email;

@property int UserID;

@property NSString* Job;

@property NSString* DepartmentID;

@property NSString* Department;

@property NSString* TelPhone;

@property NSString* Phone;

@property NSString* Address;

@property NSString* Sex;

@property (strong) NSString* RealName;

@property NSString* ENNName;


@property int OrderByNum;
@end
