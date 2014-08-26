//
//  DataService.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DataService.h"
#define BASE_URL  @"https://open.weibo.cn/2/"


@implementation DataService

+(ASIHTTPRequest*)requestWithUrl:(NSString *)urlString parmas:(NSMutableDictionary *)params httpMethod:(NSString *)method completeBlock:(RequestFinishBlock)block{
  
    //获取认证信息
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary   *sinaInfo=[defaults objectForKey:@"SinaWeiboAuthData"];
    NSString       *TokenKey=[sinaInfo objectForKey:@"AccessTokenKey"];
    urlString= [BASE_URL stringByAppendingFormat:@"%@?access_token=%@",urlString,TokenKey];
    
    //处理Get
     if ([ [method uppercaseString] isEqualToString:@"GET" ]) {
         NSMutableString *getString=[NSMutableString string];
         NSArray *allkeys=[params allKeys];
         for (int i=0; i<allkeys.count; i++  ) {
             NSString *key=[allkeys objectAtIndex:i];
             id       *value=[params objectForKey:key];
             [getString appendFormat:@"&%@=%@",key,value];

         }
         urlString=[urlString stringByAppendingString:getString];
     }
    NSURL *url=[NSURL URLWithString:urlString];
    NSLog(@"%@",url);
    
    __block  ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:method];
    //处理Post
    if ([ [method uppercaseString] isEqualToString:@"POST" ]) {
        NSArray *allkeys=[params allKeys];
        for (int i=0; i<allkeys.count; i++  ) {
            NSString *key=[allkeys objectAtIndex:i];
            id       *value=[params objectForKey:key];
            if ( [value isKindOfClass:[NSData class]]) {
                [request addData:value forKey:key];
            }else{
                [request addPostValue:value forKey:key];
            }
            
        }
    }
    
    //请求完成
    [request setCompletionBlock:^{
        NSData *data=request.responseData;
        id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (block!=nil) {
            block(result);
        }
    }];
    //异步请求
    [request startAsynchronous];
    
    
    
    return request;
}

@end
