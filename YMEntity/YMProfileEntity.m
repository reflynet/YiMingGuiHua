//
//  YMProfileEntity.m
//  yiming
//
//  Created by 叶 楠 on 15/8/4.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMProfileEntity.h"


@implementation YMProfileEntity

@synthesize   Id;
@synthesize  ModelId;
@synthesize   ParentId;
@synthesize   CateName;
@synthesize  Image;
@synthesize  Table;
@synthesize Expand;

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.Id forKey:@"P_ID"];
    [aCoder encodeInt:self.ModelId forKey:@"P_ModelID"];
    [aCoder encodeInt:self.ParentId forKey:@"P_ParentID"];
    [aCoder encodeObject:self.CateName forKey:@"P_CateName"];
    [aCoder encodeObject:self.Image forKey:@"P_Image"];
    [aCoder encodeObject:self.Table forKey:@"P_Table"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [self init])
    {
        self.Id =[aDecoder decodeIntForKey:@"P_ID"];
        self.ModelId =[aDecoder decodeIntForKey:@"P_ModelID"];
        self.ParentId =[aDecoder decodeIntForKey:@"P_ParentID"];
        self.CateName =[aDecoder decodeObjectForKey:@"P_CateName"];
        self.Image=[aDecoder decodeObjectForKey:@"P_Image"];
        self.Table=[aDecoder decodeObjectForKey:@"P_Table"];
    }
    return self;
}

@end
