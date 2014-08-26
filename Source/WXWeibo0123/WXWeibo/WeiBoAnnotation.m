//
//  WeiBoAnnotation.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-25.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiBoAnnotation.h"

@implementation WeiBoAnnotation


-(id) initWhitWeibo:(WeiboModel *)weibo{
    if (self=[super init]) {
        self.weiboModel=weibo;
    }
    return  self;
}

-(void) setWeiboModel:(WeiboModel *)weiboModel{
    if (_weiboModel!=weiboModel) {
        [_weiboModel release];
        _weiboModel=[weiboModel retain];
    }
    NSDictionary *geo= _weiboModel.geo;
    if ([geo isKindOfClass:[NSDictionary class]]) {
        NSArray *coord=[geo objectForKey:@"coordinates"];
        if (coord.count==2) {
            float lat=[[coord objectAtIndex:0] floatValue];
            float log=[[ coord objectAtIndex:1] floatValue];
            _coordinate=CLLocationCoordinate2DMake(lat, log);
        }
    }
    
}


@end
