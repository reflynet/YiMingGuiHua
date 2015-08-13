//
//  YMContactCustomerDeleteage.m
//  yiming
//
//  Created by weiwei wei on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMContactCustomerDeleteage.h"
#import "YMContactCustomerEntity.h"
#import <AFNetworking.h>
#import "YMCommon.h"

@interface YMContactCustomerDeleteage()
@property  NSMutableArray *result ;
@property  YMContactCustomerEntity* entity;

@property (weak) NSString* currentElement;
@end

@implementation YMContactCustomerDeleteage
@synthesize result;
@synthesize entity;

@synthesize currentElement;




-(void)getData : (int)ID page:(int)page compete:(void (^)(NSMutableArray *arr))compete
{
    result = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=member&a=itemlist&did=%d&pagesize=40&sortcolumn=department",[YMCommon getServer],ID];
    
    
    // NSString* requestUrl = [[YMCommon getServer] stringByAppendingString: @"client/?c=channel&a=channellist&fid=%d",31];
    
    [manager GET: requestUrl parameters:dict success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSXMLParser * parser = (NSXMLParser *)responseObject;
        
        parser.delegate =self;
        
        [parser setShouldProcessNamespaces:YES];
        [parser parse];
        
        if (compete) {
            compete(result);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
    }];
    
    
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
    
    if([elementName isEqualToString:@"item"])
    {
        
        entity = [[YMContactCustomerEntity alloc] init];
    }
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.ID = [str intValue];
    }
    if ([currentElement isEqualToString:@"userid"]) {
        entity.UserID = [str intValue];
    }
    if ([currentElement isEqualToString:@"username"]) {
        entity.UserName = str;
    }
    if ([currentElement isEqualToString:@"facephoto"]) {
        entity.FacePhoto = str;
    }
    if ([currentElement isEqualToString:@"xmppname"]) {
        entity.XmppName = str;
    }
    if ([currentElement isEqualToString:@"email"]) {
        entity.Email = str;
    }
    if ([currentElement isEqualToString:@"depaermentid"]) {
        entity.DepaermentID = [str intValue];
    }
    if ([currentElement isEqualToString:@"department"]) {
        entity.Department = str;
    }
    if ([currentElement isEqualToString:@"telphone"]) {
        entity.TelPhone = str;
    }
    if ([currentElement isEqualToString:@"phone"]) {
        entity.Phone =str;
    }
    if ([currentElement isEqualToString:@"address"]) {
        entity.Address = str;
    }
    if ([currentElement isEqualToString:@"userid"]) {
        entity.UserID = [str intValue];
    }
    if ([currentElement isEqualToString:@"sex"]) {
        entity.Sex = str;
    }
    if ([currentElement isEqualToString:@"realname"]) {
        entity.RealName =str;
    }
    if ([currentElement isEqualToString:@"enname"]) {
        entity.ENName = str;
    }
    if ([currentElement isEqualToString:@"job"]) {
        entity.Job = str;
    }
    if ([currentElement isEqualToString:@"orderbynum"]) {
        entity.OrderByNum = [str intValue];
    }
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"item"])
    {
        [result addObject:entity];
    }
}

@end