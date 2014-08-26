//
//  NearWeibMapViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-25.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>



@interface NearWeibMapViewController : BaseViewController<MKMapViewDelegate>{
  
}

@property (retain, nonatomic) IBOutlet MKMapView *mapView;


@property (nonatomic,retain) NSArray *data;

@end
