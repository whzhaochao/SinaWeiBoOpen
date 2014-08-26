//
//  FriendShipViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendShipTableView.h"

@interface FriendShipViewController : BaseViewController{
    
}
@property (nonatomic,copy) NSString* userId;

@property (nonatomic,retain) NSMutableArray *data;
@property (retain, nonatomic) IBOutlet FriendShipTableView *tableView;

@property (nonatomic,copy) NSString* urlString;

@end
