//
//  TongjiController.m
//  yiming
//
//  Created by weiwei wei on 15/8/17.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "TongjiController.h"
#import <AFNetworking.h>
#import "YMCommon.h"
#import "MRProgress.h"
@interface TongjiController ()

@end

@implementation TongjiController
@synthesize lblA1;
@synthesize lblA2;
@synthesize lblA3;
@synthesize lblA4;
@synthesize B;
@synthesize B2;
@synthesize lblB3;
@synthesize lblB4;
@synthesize currentElement;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"项目统计";
    
   MRProgressOverlayView* progress =  [MRProgressOverlayView showOverlayAddedTo:self.view animated:true];
    progress.tintColor = [YMCommon hexStringToColor:@"CF0001"];
    progress.mode =MRProgressOverlayViewModeIndeterminate;
    progress.titleLabelText = @"加载中...";

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=item&a=projectinfo",[YMCommon getServer]];
    
    [manager GET: requestUrl parameters:dict success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSXMLParser * parser = (NSXMLParser *)responseObject;
        
        parser.delegate =self;
        [progress dismiss:true];
        [parser setShouldProcessNamespaces:YES];
        [parser parse];
        
      
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {}];

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"wbig"]) {
        lblA1.text = str;
    }
    if ([currentElement isEqualToString:@"dbig"]) {
        lblA2.text = str;
    }
    if ([currentElement isEqualToString:@"wmid"]) {
        lblA3.text = str;
    }
    if ([currentElement isEqualToString:@"dmid"]) {
        lblA4.text = str;
    }
    if ([currentElement isEqualToString:@"a"]) {
        B.text = str;
    }
    if ([currentElement isEqualToString:@"b"]) {
        B2.text = str;
    }
    if ([currentElement isEqualToString:@"c"]) {
        lblB3.text = str;
    }
    if ([currentElement isEqualToString:@"d"]) {
        lblB4.text = str;
    }

}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
