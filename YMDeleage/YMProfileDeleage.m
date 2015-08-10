//
//  YMProfileDeleage.m
//  yiming
//
//  Created by 叶 楠 on 15/8/3.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMProfileDeleage.h"
#import "YMCommon.h"
#import "YMProfileEntity.h"
#import <AFNetworking.h>


@interface YMProfileDeleage()
@property  NSMutableArray *result ;
@property  YMProfileEntity* entity;

@property (weak) NSString* currentElement;
@end

@implementation YMProfileDeleage
@synthesize result;
@synthesize entity;

@synthesize currentElement;




-(void)getData : (int)ID compete:(void (^)(NSMutableArray *arr))compete
{
    result = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=channel&a=channellist&fid=%d",[YMCommon getServer],ID];
    
    
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
        
        entity = [[YMProfileEntity alloc] init];
    }
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.Id = [str intValue];
    }
    if ([currentElement isEqualToString:@"modelid"]) {
        entity.ModelId = [str intValue];
    }
    if ([currentElement isEqualToString:@"parentid"]) {
        entity.ParentId = [str intValue];
    }
    if ([currentElement isEqualToString:@"catname"]) {
        entity.CateName = str;
    }
    if ([currentElement isEqualToString:@"image"]) {
        entity.Image = str;
    }
    if ([currentElement isEqualToString:@"expand"]) {
        entity.Expand = str;
    }
    if ([currentElement isEqualToString:@"table"]) {
        entity.Table = str;
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

