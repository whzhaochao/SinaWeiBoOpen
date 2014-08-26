//
//  BrowModeController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface BrowModeController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
