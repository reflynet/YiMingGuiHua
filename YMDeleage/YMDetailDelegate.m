//
//  YMDetailDelegate.m
//  yiming
//
//  Created by 攒钱网 on 15/8/13.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMDetailDelegate.h"
#import "YMCommon.h"
#import <AFNetworking.h>
#import "YMEntityDetail.h"

@interface YMDetailDelegate()
@property  YMEntityDetail* entity;

@property NSMutableArray* result;
@property (weak) NSString* currentElement;
@end
@implementation YMDetailDelegate;

@synthesize entity;
@synthesize result;
@synthesize currentElement;

-(void)getData: (int) entityid
m:(NSString*) m
compete:(void (^)(YMEntityDetail* arr)) compete;
{
 result = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=item&a=itemdetail&id=%d&m=%@",[YMCommon getServer],
                            entityid,m];
    
    [manager GET: requestUrl parameters:dict success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSXMLParser * parser = (NSXMLParser *)responseObject;
        
        parser.delegate =self;
        
        [parser setShouldProcessNamespaces:YES];
        [parser parse];
        
        if (compete) {
            compete(entity);
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {}];
}



//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.Id = [str intValue];
    }
    else if ([currentElement isEqualToString:@"title"]) {
        entity.Wenjianbiaoti = str;
    }
    else if ([currentElement isEqualToString:@"inputtime"]) {
        entity.Fawenshijian = str;
    }
    else if([currentElement isEqualToString:@"content"]){
         entity.Content = str;
    }
    else if([currentElement isEqualToString:@"creatfiletime"]){
         entity.Fawendanwei = str;
    }
    else if([currentElement isEqualToString:@"fromunits"]){
         entity.Fawendanwei = str;
    }
    else if([currentElement isEqualToString:@"filetitle"]){
        entity.Juanzong = str;
    }else if([currentElement isEqualToString:@"registernumber"]){
        entity.Dengjihao = str;
    }else if([currentElement isEqualToString:@"isdegree"]){
        entity.Baomidengji = str;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
    
    if([elementName isEqualToString:@"item"])
    {
        
        entity = [[YMEntityDetail alloc] init];
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
