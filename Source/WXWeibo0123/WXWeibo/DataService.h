//
//  DataService.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
typedef void(^RequestFinishBlock)(id result) ;

@interface DataService : NSObject



+(ASIHTTPRequest*) requestWithUrl:(NSString*) url
                    parmas:(NSMutableDictionary*)params
                    httpMethod:(NSString*) method
                    completeBlock:(RequestFinishBlock) block;

@end
