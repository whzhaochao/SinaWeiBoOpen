//
//  MessageViewController.h
//  WXWeibo
//  消息首页控制器

//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "WeiBoTableView.h"

@interface MessageViewController : BaseViewController<UItableViewEventDelegate>{
    WeiBoTableView *_weiboTable;
    
}


@end
