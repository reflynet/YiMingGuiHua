//
//  YMReadUserDelegate.m
//  yiming
//
//  Created by 攒钱网 on 15/8/20.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMReadUserDelegate.h"
#import "YMReadUser.h"
#import "YMCommon.h"
#import <AFNetworking.h>

@interface YMReadUserDelegate()
@property  YMReadUser* entity;

@property NSMutableArray* result;
@property (weak) NSString* currentElement;
@end
@implementation YMReadUserDelegate
@synthesize entity;
@synthesize result;
@synthesize currentElement;

-(void)getData: (int) entityid compete:(void (^)(NSMutableArray* arr)) compete;
{
    result = [[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=item&a=readmember&id=%d",[YMCommon getServer],
                            entityid];
    
    [manager GET: requestUrl parameters:dict success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSXMLParser * parser = (NSXMLParser *)responseObject;
        
        parser.delegate =self;
        
        [parser setShouldProcessNamespaces:YES];
        [parser parse];
        
        if (compete) {
            compete(result);
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {}];
}



//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.id = [str intValue];
    }
    else if ([currentElement isEqualToString:@"contentid"]) {
        entity.contentid = str;
    }
    else if ([currentElement isEqualToString:@"username"]) {
        entity.username = str;
    }
    else if([currentElement isEqualToString:@"uid"]){
        entity.uid = str;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
    
    if([elementName isEqualToString:@"item"])
    {
        
        entity = [[YMReadUser alloc] init];
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
