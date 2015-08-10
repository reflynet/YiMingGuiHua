//
//  YMProfileDeleage.m
//  yiming
//
//  Created by 叶 楠 on 15/8/3.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMCityDeleage.h"
#import "YMCommon.h"
#import "YMCityEntity.h"
#import <AFNetworking.h>


@interface YMCityDeleage()
@property  NSMutableArray *result ;
@property  YMCityEntity* entity;

@property (weak) NSString* currentElement;
@end

@implementation YMCityDeleage
@synthesize result;
@synthesize entity;

@synthesize currentElement;




-(void)getData :(void (^)(NSMutableArray *arr))compete
{
    result = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=channel&a=enumstep&eid=7",[YMCommon getServer]];

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



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
    
    if([elementName isEqualToString:@"item"])
    {
        
        entity = [[YMCityEntity alloc] init];
    }
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.ID = [str intValue];
    }
    if ([currentElement isEqualToString:@"sons"]) {
        entity.Sons = str;
    }
    if ([currentElement isEqualToString:@"name"]) {
        entity.Name = str ;
    }
    if ([currentElement isEqualToString:@"selectid"]) {
        entity.SelectID = [str intValue];
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

