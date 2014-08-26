//
//  HomeViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "WeiBoTableView.h"
#import "UIFactory.h"
#import "AudioToolbox/AudioToolbox.h"
#import "MainViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark-baseView  Event
-(void) pullDown:(BaseTableView *)tableView{
    
     NSLog(@"pullDown");
    
   //  [self loadWeiboData];
    
    
    [self pullDownWeiBo];
    
    
    //[tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3 ];

    
}
//上拉加载数据
-(void) pullUp:(BaseTableView *)tableView{
    NSLog(@"pullup");
    
    [self pullUpWeiBo];
    
}
//上拉加载更多
-(void)pullUpWeiBo{
    NSLog(@"%@",self.lastWeiBoId);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    [params setObject:@"20" forKey:@"count"];
    [params setObject:self.lastWeiBoId   forKey:@"max_id"];
        
 
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result){
                                 [self pullUpFinishData:result];
                             }];
}

-(void) pullUpFinishData:(id) result{
    NSArray *statues = [result objectForKey:@"statuses"];
    if (statues.count>0) {
        
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            [weibos addObject:weibo];
            [weibo release];
        }
    
        //更新topweiboId
        if (weibos.count>0) {
                [weibos removeObjectAtIndex:0];
            WeiboModel *topWeibo=[weibos lastObject];
            self.lastWeiBoId=[topWeibo.weiboId stringValue] ;
        }
        [self.weibos addObjectsFromArray:weibos];
        if (statues.count>=20) {
            self.tableView.isMore=YES;
        }else{
            self.tableView.isMore=NO;
        }
        
        self.tableView.data=self.weibos;
        [self.tableView reloadData];
        
    }else{
        //显示更新数目
        NSLog(@"更新weiob数目:0");
    }
    

    
}


//下拉加载最新
-(void)pullDownWeiBo{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    [params setObject:@"20" forKey:@"count"];
    if (self.topWeiBoId!=nil) {
        NSLog(@"%@====",self.topWeiBoId);
        NSString *id=[NSString stringWithFormat:@"%@",self.topWeiBoId];
        [params setObject:id   forKey:@"since_id"];
        
    }

    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result){
                                 [self pullDownFinishData:result];
                             }];
}
-(void) pullDownFinishData:(id) result{
    NSArray *statues = [result objectForKey:@"statuses"];
    if (statues.count>0) {
        
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
        for (NSDictionary *statuesDic in statues) {
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            [weibos addObject:weibo];
            [weibo release];
        }
        //更新topweiboId
        if (weibos.count>0) {
            WeiboModel *topWeibo=[weibos objectAtIndex:0];
            self.topWeiBoId=topWeibo.weiboId ;
        }
        
        //新数据加
        [weibos addObjectsFromArray:self.weibos];
        self.weibos=weibos;
        self.tableView.data=weibos;
        
        //刷新数据
        [self.tableView reloadData];
       
        //显示更新数目

        [self showNewWeiBoCount:statues.count];
    }else{
        //显示更新数目
        NSLog(@"更新weiob数目:0");
    }

    //下拉弹回
    [self.tableView doneLoadingTableViewData];
    
}
//刷新UI
-(void) showNewWeiBoCount:(NSInteger) count{
    NSLog(@"更新weiob数目:%d",count);
    
    if (barView==nil) {
        barView=[[UIFactory createImageView:@"timeline_new_status_background.png"] retain];
        UIImage *image=[barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        barView.image=image;
        barView.leftCapWidth=5;
        barView.topCapHeight=5;
        barView.frame=CGRectMake(5, -40, ScreenWidth-10, 40);
        [self.view addSubview:barView];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
        label.tag=2014;
        label.font=[UIFont systemFontOfSize:16.0f];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor clearColor];
        [barView addSubview:label];
        
    }
    if (count>0) {
        [self playMusic];
        UILabel *label=(UILabel*)[ barView viewWithTag:2014];
        label.text=[NSString stringWithFormat:@"%d条微博",count];
        [label sizeToFit];
        label.origin=CGPointMake((barView.width-label.width)/2, (barView.height-label.height)/2);
        [UIView animateWithDuration:0.6 animations:^{
            barView.top=5;
        }completion:^(BOOL finish){
            if (finish) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelay:1];
                [UIView setAnimationDuration:0.6];
                barView.top=-40;
                [UIView commitAnimations];
            }
        }];
    }

    
    
}

-(void)playMusic{
    NSString *filePaht=[[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url=[NSURL fileURLWithPath:filePaht];
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((CFURLRef)url,  &soundId);
    AudioServicesPlaySystemSound(soundId);
    //去掉显示数目
    MainViewController* main=  self.tabBarController;
    [main showMainBagde:NO];
    
    
}



- (void)viewDidLoad
{
   // [super showStatusTip:YES title:@"发送中..."];
         [UIApplication sharedApplication].statusBarHidden=NO;
    [super viewDidLoad];
    
    //绑定按钮
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = [bindItem autorelease];
    
    //注销按钮
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
    self.navigationItem.leftBarButtonItem = [logoutItem autorelease];
    
    
    //创建weibo
    _tableView=[[WeiBoTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-49-44) style:UITableViewStylePlain];
    _tableView.eventDelegate=self;

    [self.view addSubview:_tableView];

    
    
    //判断是否认证
    if (self.sinaweibo.isAuthValid) {
        //加载微博列表数据
        [self loadWeiboData];
    }else{
        [self.sinaweibo logIn];
    }
}

#pragma mark - load Data
- (void)loadWeiboData {
    //隐藏tableView
    _tableView.hidden=YES;
    //显示加载提示
   // [super showLoading:YES];
    [super showHUD:@"加载网络..." isDim:YES];

    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"10" forKey:@"count"];
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                          delegate:self];
}

#pragma mark - SinaWeiboRequest delegate
//网络加载失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"网络加载失败:%@",error);
}

//网络加载完成
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    //隐藏加载提示
   // [super showLoading:NO];
    [super hiddenHUD];
    //显示tableView
    _tableView.hidden=NO;
    
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDic in statues) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    
    self.tableView.data = weibos;
    self.weibos=weibos;
    
    if (weibos.count>0) {
        WeiboModel *weibo= [weibos objectAtIndex:0];
        _topWeiBoId=weibo.weiboId ;
        WeiboModel *lastWeibo= [weibos lastObject];
        self.lastWeiBoId=[lastWeibo.weiboId stringValue];
    }
    
    
    //刷新tableView
    [self.tableView reloadData];
}

#pragma mark - actions
- (void)bindAction:(UIBarButtonItem *)buttonItem {
    [self.sinaweibo logIn];
}

- (void)logoutAction:(UIBarButtonItem *)buttonItem {
    [self.sinaweibo logOut];
}

#pragma mark - Memery Manager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

- (void)viewDidUnload {
    
}
-(void)refreashWeibo{
    //显示下拉
    [self.tableView refreshData];
    //加载数据
    [self pullDownWeiBo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启左滑
    AppDelegate *appd=[super appDelegate];
    [appd.menuCtrl setEnableGesture:YES];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //禁止左滑
    AppDelegate *appd=[super appDelegate];
    [appd.menuCtrl setEnableGesture:NO];
}

@end
