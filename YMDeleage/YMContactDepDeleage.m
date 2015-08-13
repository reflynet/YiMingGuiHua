#import "YMContactDepDeleage.h"
#import "YMCommon.h"
#import "YMContactDepEntity.h"
#import <AFNetworking.h>


@interface YMContactDepDeleage()

@property  NSMutableArray *result ;
@property  YMContactDepEntity* entity;

@property (weak) NSString* currentElement;
@end



@implementation YMContactDepDeleage
@synthesize result;
@synthesize entity;

@synthesize currentElement;




-(void)getData :(int)type compete:(void (^)(NSMutableArray *arr))compete
{
    result = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFXMLParserResponseSerializer * responseSer = [AFXMLParserResponseSerializer new];
    [manager setResponseSerializer:responseSer];
    
    NSDictionary *dict =@{@"format":@"xml"};
    
    NSString* requestUrl = [NSString stringWithFormat:@"%@client/?c=channel&a=enumstep&eid=9&pagesize=40",[YMCommon getServer]];
    
    if(type > 0)
    {
        requestUrl = [NSString stringWithFormat:@"%@client/?c=channel&a=enumstep&pagesize=60&pageindex=1&fid=%d&sortcolumn=orderby&sortmethod=asc",[YMCommon getServer],type];
    }
    
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
        
       entity = [[YMContactDepEntity alloc] init];
    }
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    @try
    {
    if ([currentElement isEqualToString:@"id"]) {
       entity.ID = [str intValue];
    }
    if ([currentElement isEqualToString:@"sons"]) {
        entity.Sons = [str intValue];
    }
    if ([currentElement isEqualToString:@"parentid"]) {
        entity.ParentID = [str intValue]  ;
    }
    if ([currentElement isEqualToString:@"enname"]) {
        entity.ENName = str;
    }
    if ([currentElement isEqualToString:@"name"]) {
        entity.Name = str;
    }
    if ([currentElement isEqualToString:@"orderby"]) {
       entity.OrderBy = [str intValue];
    }
    if ([currentElement isEqualToString:@"selectid"]) {
        entity.SelectID = [str intValue];
    }
    }
    @catch(NSException *exception){}
    
    //if ([currentElement isEqualToString:@"parentid"]) {
    //    entity.ParentID = [str intValue];
   // }

    
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"item"])
    {
        if(entity != nil)
        {
        [result addObject:entity];
        }
    }
}


-(NSMutableDictionary*)convertToDictionaryByResult: (NSMutableArray*) arr
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
  
    
    for (int i =0; i<[arr count];i++) {
        YMContactDepEntity *current = arr[i];
        
        NSMutableString *pinYin = [NSMutableString stringWithString:current.Name];
        if([pinYin length]>0)
        {
            CFStringTransform((CFMutableStringRef)pinYin, NULL, kCFStringTransformToLatin, false);
            
            NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString* __pin = [[NSString alloc]initWithData:[pinYin dataUsingEncoding: NSUTF8StringEncoding] encoding:enc];
            NSString* _pinYIn = [__pin substringWithRange: NSMakeRange(0,1)];
            pinYin = [_pinYIn uppercaseString];
            
            
            //      NSString *subString = [pinYin substringWithRange:rang];
            NSMutableArray* _arr=   [mDict objectForKey:pinYin];
            if(_arr !=nil)
            {
                [_arr addObject:current];
            }
            else if(_arr == nil)
            {
                _arr =[[NSMutableArray alloc]init] ;
                [_arr addObject:current];
                
                [mDict setObject:_arr forKey:pinYin];
                
                
            }
            
            
        }
        else
        {
            NSMutableArray* _arr=   [mDict objectForKey:@"?"];
            [_arr addObject:current];
        }
        
    }
    return  mDict;
    
}





@end
