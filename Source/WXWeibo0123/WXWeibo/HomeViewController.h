//
//  HomeViewController.h
//  WXWeibo
//  首页控制器

//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiBoTableView.h"
#import "UIFactory.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SinaWeiboRequestDelegate,UItableViewEventDelegate>{
    ThemeImageView *barView;
}



@property (retain,nonatomic) WeiBoTableView *tableView;

@property (nonatomic,assign) NSString* topWeiBoId;  //最顶上微博

@property (nonatomic,copy) NSString* lastWeiBoId;  //最低下微博

@property (nonatomic,retain) NSMutableArray *weibos; 


-(void) refreashWeibo;

@end
