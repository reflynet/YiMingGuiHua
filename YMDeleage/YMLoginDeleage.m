//
//  YMLoginDeleage.m
//  yiming
//
//  Created by 叶 楠 on 15/8/4.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "YMLoginDeleage.h"
#import "YMCommon.h"
#import <AFNetworking.h>

@interface YMLoginDeleage()
@property NSString* currentElement;

@end

@implementation YMLoginDeleage

@synthesize result;
@synthesize currentElement;




-(void)login:(NSString *) userName
pwd:(NSString *) pwd
compete :(void (^)(YMCustomerEntity*))compete
{
    
    NSString* content= [NSString stringWithFormat:@"<item><password>%@</password><username>%@</username></item>",pwd,userName];
    
       NSString* requestUrl = [[YMCommon getServer] stringByAppendingString: @"client/?c=member&a=login" ];
    
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
                                               result = nil;
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


//解析起始标记

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
 
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    
    if ([currentElement isEqualToString:@"flag"]) {
        result = [[YMCustomerEntity alloc] init];
    }
  

       if ([currentElement isEqualToString:@"id"]) {
        result.ID = [str intValue];
    }
    if ([currentElement isEqualToString:@"truename"]) {
        result.TrueName = str;
    }
    if ([currentElement isEqualToString:@"name"]) {
        result.Name = str;
    }
    if ([currentElement isEqualToString:@"image"]) {
        result.Job = str;
    }
    
    if ([currentElement isEqualToString:@"modelid"]) {
        result.Name = str;
    }
    if ([currentElement isEqualToString:@"parentid"]) {
        result.GradeId = [str intValue];
    }
    if ([currentElement isEqualToString:@"catname"]) {
        result.GradeName = str;
    }
    if ([currentElement isEqualToString:@"xmppname"]) {
        result.XmppName = str;
    }
    if ([currentElement isEqualToString:@"img"]) {
        result.Img = str;
    }
    
}


@end
