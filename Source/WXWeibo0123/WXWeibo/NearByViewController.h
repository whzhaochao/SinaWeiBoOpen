//
//  NearByViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-21.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef void(^SelectDoneBlock)(NSDictionary*);

@interface NearByViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    
}

@property (nonatomic,retain) NSArray *data;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) SelectDoneBlock selectBlock;

@end
