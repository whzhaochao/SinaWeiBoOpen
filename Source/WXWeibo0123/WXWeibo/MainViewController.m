//
//  MainViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "UIFactory.h"
#import "ThemeButton.h"
#import "AppDelegate.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _initViewController];
    [self _initTabbarView];
    //定时查看未读微博
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
}
//定时器action
-(void) timerAction:(NSTimer*) timer{
    [self loadUnReadWeibo];
}
- (SinaWeibo *)sinaweibo {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    return sinaweibo;
}
//加载未读微博
-(void) loadUnReadWeibo{
    SinaWeibo* weibo=[self sinaweibo];
    [weibo requestWithURL:@"remind/unread_count.json" params:nil httpMethod:@"GET" block:^(NSDictionary* result) {
        [self refreashUnreadWeiBo:result];
    }];
}
//显示未读微博个数
-(void) refreashUnreadWeiBo:(NSDictionary*)count{
     NSNumber* unread=[count objectForKey:@"status"];
    if (main_badge==nil) {
        main_badge=[UIFactory createImageView:@"main_badge.png"];
        main_badge.hidden=YES;
        main_badge.frame=CGRectMake(64-20, 5, 20, 20);
        [_tabbarView addSubview:main_badge];
        UILabel *badgeLabel=[[UILabel alloc] initWithFrame:main_badge.bounds];
        badgeLabel.textAlignment=NSTextAlignmentCenter;
        badgeLabel.font=[UIFont systemFontOfSize:13.0f];
        badgeLabel.backgroundColor=[UIColor clearColor];
        badgeLabel.textColor=[UIColor purpleColor];
        badgeLabel.tag=100;
        [main_badge addSubview:badgeLabel];
        
    }
    int n=[unread intValue];
    if (n>0) {
        if (n>99) {
            n=99;
        }
        UILabel *label=(UILabel*)[main_badge viewWithTag:100];
        label.text=[NSString stringWithFormat:@"%d",n];
        main_badge.hidden=NO;
    }else{
        main_badge.hidden=YES;
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化子控制器
- (void)_initViewController {
    HomeViewController *home = [[[HomeViewController alloc] init] autorelease];
    MessageViewController *message = [[[MessageViewController alloc] init] autorelease];
    UserViewController *profile = [[[UserViewController alloc] init] autorelease];
    profile.userName=@"://@赵侠客";
    DiscoverViewController *discover = [[[DiscoverViewController alloc] init] autorelease];
    MoreViewController *more = [[[MoreViewController alloc] init] autorelease];
    
    NSArray *views = @[home,message,profile,discover,more];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:nav];
    
        [nav release];
        nav.delegate=self;
        
    }
    
    self.viewControllers = viewControllers;
}

//创建自定义tabBar
- (void)_initTabbarView {
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
//    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    [self.view addSubview:_tabbarView];
    
    UIImageView *tabbarGroundImage = [UIFactory createImageView:@"tabbar_background.png"];
    tabbarGroundImage.frame = _tabbarView.bounds;
    [_tabbarView addSubview:tabbarGroundImage];
    
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray *heightBackground = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        
//        ThemeButton *button = [[ThemeButton alloc] initWithImage:backImage highlighted:heightImage];
        UIButton *button = [UIFactory createButton:backImage highlighted:heightImage];
        //显示高亮
        button.showsTouchWhenHighlighted=YES;
        
        button.frame = CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag = i;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    
    _sliderView = [[UIFactory createImageView:@"tabbar_slider.png"] retain];
    _sliderView.backgroundColor = [UIColor clearColor];
    _sliderView.frame = CGRectMake((64-15)/2, 5, 15, 44);
    [_tabbarView addSubview:_sliderView];
}

#pragma mark - actions
//tab 按钮的点击事件
- (void)selectedTab:(UIButton *)button {
   
    
    
    float x = button.left + (button.width-_sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = x;
    }];
    //是否重复点击
    if (self.selectedIndex==button.tag && button.tag==0) {
        //下拉刷新
        UINavigationController *homeNav=[self.viewControllers objectAtIndex:0];
        HomeViewController *homeCtrl=[homeNav.viewControllers objectAtIndex:0];
        [homeCtrl refreashWeibo];
    }
    
    self.selectedIndex = button.tag;
    
    
}
//登录成功
#pragma mark - SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    //保存认证的数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //登录成功
    //发送通知刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadWeiboTableNofication object:nil];
    NSLog(@"登录成功！AccessTokenKey=%@ userId=%@ ", sinaweibo.accessToken,sinaweibo.userID);
    
    
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"退出成功！");
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo {
    NSLog(@"sinaweiboLogInDidCancel");    
}

-(void) showMainBagde:(BOOL)show{
    main_badge.hidden=!show;
}
-(void) showTabBar:(BOOL)show{
    [UIView animateWithDuration:0.01 animations:^{
        if (show) {
            _tabbarView.left=0;
        }else{
            _tabbarView.left=-ScreenWidth;
        }
    }];
}
#pragma mark -nav deleteg
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //航控制器个数
    int count=navigationController.viewControllers.count;
    if (count==2) {
        [self showTabBar:NO];
    }else if (count==1){
        [self showTabBar:YES];
    }
        
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

@end
