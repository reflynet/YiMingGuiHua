//
//  YMProfileDeleage.m
//  yiming
//
//  Created by 叶 楠 on 15/8/3.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMItemDeleage.h"
#import "YMCommon.h"
#import "YMChannelItem.h"
#import <AFNetworking.h>


@interface YMItemDeleage()
@property  NSMutableArray *result ;
@property  YMChannelItem* entity;

@property (weak) NSString* currentElement;
@end

@implementation YMItemDeleage
@synthesize result;
@synthesize entity;

@synthesize currentElement;




-(void)getData : (int)ID page:(int)page key:(NSString*)key m:(NSString*)m Att:(NSString*)attr compete:(void (^)(NSMutableArray *arr))compete
{
    result = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=item&a=itemlist&catid=%d&m=%@&att=%@&pagesize=10&pageindex=%d&titlekey=%@",[YMCommon getServer],ID,m,attr,page,key];
    
    
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
        
        entity = [[YMChannelItem alloc] init];
    }
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.Id = [str intValue];
    }
    if ([currentElement isEqualToString:@"expire"]) {
        entity.Expire = [str intValue];
    }
    if ([currentElement isEqualToString:@"catid"]) {
        entity.CateId = [str intValue];
    }
    if ([currentElement isEqualToString:@"template"]) {
        entity.Template = str;
    }
    if ([currentElement isEqualToString:@"thumb"]) {
        entity.Thumb = str;
    }
    if ([currentElement isEqualToString:@"inputtime"]) {
        entity.InputTime = str;
    }
    if ([currentElement isEqualToString:@"description"]) {
        entity.Description = str;
    }
    if ([currentElement isEqualToString:@"title"]) {
        entity.Title = str;
    }
    if ([currentElement isEqualToString:@"clicks"]) {
        entity.Clicks = [str intValue];
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

