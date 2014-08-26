//
//  WeiBoAnnotation.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-25.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"
@interface WeiBoAnnotation : NSObject<MKAnnotation>


@property (nonatomic,retain) WeiboModel *weiboModel;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
// Title and subtitle for use by selection UI.
//@property (nonatomic, readonly, copy) NSString *title;
//@property (nonatomic, readonly, copy) NSString *subtitle;


-(id) initWhitWeibo:(WeiboModel*) weibo;

@end
