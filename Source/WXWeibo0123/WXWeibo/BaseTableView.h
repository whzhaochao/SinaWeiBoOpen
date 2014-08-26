//
//  BaseTableView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-9.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseTableView;

@protocol UItableViewEventDelegate <NSObject>
@optional
//下拦
-(void) pullDown:(BaseTableView*) tableView;
//上拦
-(void) pullUp:(BaseTableView*) tableView;
//选中
-(void) tableView:(BaseTableView*) tableView selectRowAtIndexPath:(NSIndexPath *)indexPath;


@end


@interface BaseTableView : UITableView <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL  _reloading;
    //上拉加载更多
    UIButton* _moreButton;
    
}

@property (nonatomic,assign) BOOL refershHeader ;//是否下拉

@property (nonatomic,retain) NSArray *data; //为tableview数据

@property (nonatomic,retain) id<UItableViewEventDelegate>  eventDelegate;

@property (nonatomic,assign) BOOL isMore;  //是否有更多

- (void)doneLoadingTableViewData;

-(void) refreshData;

@end
