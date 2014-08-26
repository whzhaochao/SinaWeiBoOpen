//
//  BaseViewController.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface BaseViewController : UIViewController{
    UIView* _loadView;
    UIWindow *_tipWindow;
}

@property(nonatomic,assign)BOOL isBackButton;
@property (nonatomic,assign) BOOL isCancelButton; //取消
@property (nonatomic,retain) MBProgressHUD* hud;

- (SinaWeibo *)sinaweibo;

-(AppDelegate*) appDelegate;

//提示
-(void) showLoading:(BOOL) show;

-(void) showHUD:(NSString*) title isDim :(BOOL) isDim;
-(void)  showHUDComplete:(NSString*) title;
-(void)  hiddenHUD;
//装态栏提示
-(void) showStatusTip:(BOOL)show title:(NSString*)title;


@end
