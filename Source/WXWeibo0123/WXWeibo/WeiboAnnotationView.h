//
//  WeiboAnnotationView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-25.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView{
    UIImageView *_userImage;
    UIImageView *_weiboImage;
    UILabel     *_textLabel;
}


@end
