//
//  YMCommon.m
//  yiming
//
//  Created by 叶 楠 on 15/8/1.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMCommon.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@implementation YMCommon

+(NSString*)getServer
{
    return @"http://ymoffice.testweb.iwanshang.cn/";
}

+(NSData*) getDataFromString:(NSString*) str
{
    
  NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];
    return  xmlData;
}
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

+(void)setBackBtn:(UINavigationItem*) nav
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    nav.backBarButtonItem = barButtonItem;
}

+(void)saveAddress:(NSString*)userName tel:(NSString*)tel phone:(NSString*)phohe
{
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    // 新建一个联系人
    // ABRecordRef是一个属性的集合，相当于通讯录中联系人的对象
    // 联系人对象的属性分为两种：
    // 只拥有唯一值的属性和多值的属性。
    // 唯一值的属性包括：姓氏、名字、生日等。
    // 多值的属性包括:电话号码、邮箱等。
    ABRecordRef person = ABPersonCreate();
    NSString *firstName = userName;
    NSString *lastName = @"";
    NSDate *birthday = [NSDate date];
    // 电话号码数组
    NSArray *phones = [NSArray arrayWithObjects:phohe,tel,nil];
    // 电话号码对应的名称
    NSArray *labels = [NSArray arrayWithObjects:@"iphone",@"home",nil];
    // 保存到联系人对象中，每个属性都对应一个宏，例如：kABPersonFirstNameProperty
    // 设置firstName属性
    ABRecordSetValue(person, kABPersonFirstNameProperty,(__bridge CFStringRef)firstName, NULL);
    // 设置lastName属性
    ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFStringRef)lastName, NULL);
    // 设置birthday属性
    ABRecordSetValue(person, kABPersonBirthdayProperty,(__bridge CFDateRef)birthday, NULL);
    // ABMultiValueRef类似是Objective-C中的NSMutableDictionary
    ABMultiValueRef mv =ABMultiValueCreateMutable(kABMultiStringPropertyType);
    // 添加电话号码与其对应的名称内容
    for (int i = 0; i < [phones count]; i ++) {
        ABMultiValueIdentifier mi = ABMultiValueAddValueAndLabel(mv,(__bridge CFStringRef)[phones objectAtIndex:i], (__bridge CFStringRef) phones[i], &mi);
        
 
    }
    // 设置phone属性
    ABRecordSetValue(person, kABPersonPhoneProperty, mv, NULL);
    // 释放该数组
    if (mv) {
        CFRelease(mv);
    }
    // 将新建的联系人添加到通讯录中
    ABAddressBookAddRecord(addressBook, person, NULL);
    // 保存通讯录数据
    ABAddressBookSave(addressBook, NULL);
    // 释放通讯录对象的引用
    if (addressBook) {
        CFRelease(addressBook);
    }
}

@end