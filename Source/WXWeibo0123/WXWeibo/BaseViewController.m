//
//  BaseViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "UIFactory.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = YES;
        self.isCancelButton=NO;
    }
    return self;
}

- (void)viewDidLoad
{

    
    [super viewDidLoad];

    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && self.isBackButton) {
        UIButton *button = [UIFactory createButton:@"navigationbar_back.png" highlighted:@"navigationbar_back_highlighted.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        //显示高亮
        button.showsTouchWhenHighlighted=YES;
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = [backItem autorelease];
    }
    if (self.isCancelButton) {
        UIButton *button=[ UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(cancleActoin)];
        UIBarButtonItem *cancleButton=[[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem=cancleButton;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancleActoin{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//override
//设置导航栏上的标题
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    titleLabel.textColor = [UIColor blackColor];
    UILabel *titleLabel = [UIFactory createLabel:kNavigationBarTitleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

- (SinaWeibo *)sinaweibo {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    return sinaweibo;
}
#pragma mark -loading

-(void) showLoading:(BOOL)show{
    if (_loadView==nil) {
        _loadView=[[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight/2-80, ScreenWidth, 20)];
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        //正在加载的Label
        UILabel *loadLabel=[[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor=[UIColor clearColor];
        loadLabel.font=[UIFont boldSystemFontOfSize:16.0];
        loadLabel.text=@"正在加载...";
        loadLabel.textColor=[UIColor blackColor];
        [loadLabel sizeToFit];
        loadLabel.left=(320-loadLabel.width)/2;
        activityView.right=loadLabel.left-5;
        [_loadView addSubview:loadLabel];
        [_loadView addSubview:activityView];
        
    }
    if(show){
        if (![_loadView superview]) {
            [self.view addSubview:_loadView];
        }
    }else{
        [_loadView removeFromSuperview];
    }
}

-(void) showHUD:(NSString *)title isDim:(BOOL)isDim{
    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground=isDim;
    self.hud.labelText=title;
}
-(void) hiddenHUD{
    [self.hud hide:YES];
}
-(void) showHUDComplete:(NSString *)title{
    
}

-(AppDelegate*) appDelegate{
     AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return  appDelegate;
}

-(void) showStatusTip:(BOOL)show title:(NSString *)title{
    if (_tipWindow==nil) {
        _tipWindow=[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        _tipWindow.windowLevel=UIWindowLevelStatusBar;
        _tipWindow.backgroundColor=[UIColor blackColor];
        UILabel *tipLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        tipLable.textAlignment=UITextAlignmentCenter;
        tipLable.font=[UIFont systemFontOfSize:13];
        tipLable.textColor=[UIColor whiteColor];
        tipLable.backgroundColor=[UIColor clearColor];
        tipLable.tag=2013;
        [_tipWindow addSubview:tipLable];
        UIImageView *progress=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"send_pregress.png"]];
        progress.frame=CGRectMake(0, 20-6, 100, 6);
        progress.tag=2014;
        [_tipWindow addSubview:progress];

    }
    UILabel *tipLable=[_tipWindow viewWithTag:2013];
    UIImageView *progress=[_tipWindow viewWithTag:2014];
    if (show) {
        _tipWindow.hidden=NO;
        tipLable.text=title;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve: UIViewAnimationCurveLinear];
        [UIView setAnimationRepeatCount:1000];
         progress.left=ScreenWidth;
        
        [UIView commitAnimations];
        
        
    }else{
    
        tipLable.text=title;
        //延迟1.5秒
        [self performSelector:@selector(removeTipWidonw) withObject:nil afterDelay:1.5];
    }
}
//移除tipwindows
-(void) removeTipWidonw{
    _tipWindow.hidden=YES;
    [_tipWindow release];
    _tipWindow=nil;
}

@end
