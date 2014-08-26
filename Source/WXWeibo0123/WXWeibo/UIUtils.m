//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"


@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

+(NSString*) paraseLink:(NSString *)text{

    
    NSMutableString *_parseText=[[NSMutableString alloc] init];
      [_parseText setString:@""];
    
    NSString *reg=@"(@\\w+)";
    NSString *huti=@"#\\w+#";
    NSString *http=@"(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    NSString *all=@"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    
    NSArray* array= [text componentsMatchedByRegex:all];
    for (NSString*s in array ) {
        
        NSString *url=@"";
        
        NSString * encodingString = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        if( [s hasPrefix:@"@"]){
            url=[NSString stringWithFormat:@"<a href='user://%@'>%@</a>",encodingString,s];
            
        }else if([s hasPrefix:@"#"]){
            url=[NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",encodingString,s];
        }else if( [s hasPrefix:@"http"]){
            url=[NSString stringWithFormat:@"<a href='%@'>%@</a>",encodingString,s];
            
        }
        text=  [text stringByReplacingOccurrencesOfString:s withString:url];
        
    }
    [_parseText appendString:text];
    
    return _parseText;
}

@end
