//
//  UserViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiBoTableView.h"
#import "UserModel.h"
#import "UserInfoView.h"

@interface UserViewController : BaseViewController<UItableViewEventDelegate>{
    NSMutableArray *_requests; //当前请求对象
}

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,retain) UserModel *userInfo;

@property (nonatomic,retain) UserInfoView* userView;

@property (retain, nonatomic) IBOutlet WeiBoTableView *tableView;



@end
