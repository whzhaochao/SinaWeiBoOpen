//
//  DetailViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "CommentTabView.h"

@interface DetailViewController : BaseViewController<UItableViewEventDelegate>{
    WeiboView* _weiboView;
}
@property(nonatomic,retain) WeiboModel* weiboModel;
@property (retain, nonatomic) IBOutlet CommentTabView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *userImageView;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UIView *userBarView;

@end
