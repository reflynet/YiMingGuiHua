//
//  YMProfileDeleage.m
//  yiming
//
//  Created by 叶 楠 on 15/8/3.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMSelectProjectDeleage.h"
#import "YMCommon.h"
#import "YMChannelItem.h"
#import <AFNetworking.h>


@interface YMSelectProjectDeleage()
@property  NSMutableArray *result ;
@property  YMChannelItem* entity;

@property (weak) NSString* currentElement;
@end

@implementation YMSelectProjectDeleage
@synthesize result;
@synthesize entity;

@synthesize currentElement;




-(void)getData : (int)pageSize page:(int)page key:(NSString*)key city:(NSString*)city type:(NSString*)type pStatus:(NSString*)pStatus compete:(void (^)(NSMutableArray *arr))compete
{  result = [[NSMutableArray alloc]init];
    NSString* content= [NSString stringWithFormat:@"<item><design_organization></design_organization><pagesize>%d</pagesize><pageindex>%d</pageindex><pstatus>%@</pstatus><belongarea>%@</belongarea><type>%@</type><projectowners></projectowners ><belongvalley></belongvalley><titlekey>%@</titlekey></item>",pageSize,page,pStatus,city,type,key];
    
    NSString* requestUrl = [[YMCommon getServer] stringByAppendingString: @"client/?c=item&a=searchlist" ];
    
    NSURL* url =[NSURL URLWithString:requestUrl];
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml; charset=utf8" forHTTPHeaderField:@"Contsetent-Type"];
    [request setHTTPBody:[YMCommon getDataFromString:content]];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    
    NSOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSXMLParser * parser = (NSXMLParser *)responseObject;
                                         //result = nil;
                                         parser.delegate =self;
                                         
                                         [parser setShouldProcessNamespaces:YES];
                                         [parser parse];
                                         
                                         if (compete) {
                                             compete(result);
                                         }
                                         
                                     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         // 失败后的处理
                                         NSLog(error.description);
                                     }];
    [manager.operationQueue addOperation:operation];
    

    
    
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
        if(entity.Id>0)
        {
            [result addObject:entity];
        }
    }
}

@end

