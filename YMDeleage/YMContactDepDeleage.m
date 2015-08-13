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
    
    if(type == 2)
    {
     requestUrl = [NSString stringWithFormat:@"%@client/?c=channel&a=enumstep&eid=9&pagesize=40",[YMCommon getServer]];
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
        
        entity = [[YMContactEntity alloc] init];
    }
}

//解析文本节点

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str{
    if ([currentElement isEqualToString:@"id"]) {
        entity.Id = [str intValue];
    }
    if ([currentElement isEqualToString:@"realname"]) {
        entity.RealName = str;
    }
    if ([currentElement isEqualToString:@"telphone"]) {
        entity.TelPhone = str ;
    }
    if ([currentElement isEqualToString:@"phone"]) {
        entity.Phone = str;
    }
    if ([currentElement isEqualToString:@"email"]) {
        entity.Email = str;
    }
    if ([currentElement isEqualToString:@"job"]) {
        entity.Job = str;
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


-(NSMutableDictionary*)convertToDictionaryByResult: (NSMutableArray*) arr
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
    /*
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"A"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"B"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"C"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"D"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"E"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"F"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"G"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"H"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"I"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"J"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"K"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"L"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"M"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"N"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"O"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"P"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"Q"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"R"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"S"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"T"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"U"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"V"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"W"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"X"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"Y"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"Z"];
     [mDict setObject:[[NSMutableArray alloc]init] forKey:@"?"];*/
    
    for (int i =0; i<[arr count];i++) {
        YMContactEntity *current = arr[i];
        
        NSMutableString *pinYin = [NSMutableString stringWithString:current.RealName];
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
    
    
    
    //CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
}





@end
