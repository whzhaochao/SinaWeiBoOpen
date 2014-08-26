//
//  BaseTableView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-9.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}
-(void) awakeFromNib{
    [self _initView];
}


-(void) _initView{
    
     _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [self addSubview:_refreshHeaderView];
    
    self.dataSource=self;
    self.delegate=self;
    
    self.refershHeader=YES;
    
    _moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.backgroundColor=[UIColor clearColor];
    _moreButton.frame=CGRectMake(0, 0, ScreenWidth, 40);
    _moreButton.titleLabel.font=[UIFont systemFontOfSize:16.0f];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreButton setTitle:@"上拦加载更多..." forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    //加载提示
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     activityView.frame=CGRectMake(10, 10, 20, 20);
    activityView.tag=1;
    [activityView stopAnimating];
    [_moreButton addSubview:activityView];
    
    
    self.tableFooterView=_moreButton;
    
}
-(void)_startLoadMore{
    
    
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreButton.enabled=NO;
    UIActivityIndicatorView *ac=[_moreButton viewWithTag:1];
    [ac startAnimating];
    
}

-(void)_stopLoadMore{
    if (self.data.count>0) {
        _moreButton.hidden=NO;
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        _moreButton.enabled=YES;
        UIActivityIndicatorView *ac=[_moreButton viewWithTag:1];
        [ac stopAnimating];
        
        if (!self.isMore) {
            [_moreButton setTitle:@"加载完成" forState:UIControlStateNormal];
        }
    }else{
        _moreButton.hidden=YES;
    }

    
}
//上拦加载更多
-(void) loadMoreAction{
   
    [self _startLoadMore];
    
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(void) reloadData{
    [super reloadData];
    [self _stopLoadMore];
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//开始没去
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
//停止滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    

    
	float offset=scrollView.contentOffset.y;
    float contentSize=scrollView.contentSize.height;
    float sub=contentSize-offset;
    if (scrollView.height-sub>0) {
         NSLog(@"%f %f %f",offset, contentSize,contentSize-offset);
        [self _startLoadMore];
        [self.eventDelegate pullUp:self];
    }
   
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
  

	[self reloadTableViewDataSource];
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
     NSLog(@"下拉");
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];

    }
    
    
	
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中");
    if ([self.eventDelegate respondsToSelector:@selector(tableView:selectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self selectRowAtIndexPath:indexPath];
    }
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
-(void) refreshData{
    [_refreshHeaderView refreshLoading:self];
}



@end
