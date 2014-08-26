//
//  MainViewController.h
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "UIFactory.h"

@interface MainViewController : UITabBarController<SinaWeiboDelegate,UINavigationControllerDelegate> {
    UIView *_tabbarView;
    UIImageView *_sliderView;
    ThemeImageView *main_badge;
}

-(void) showMainBagde:(BOOL) show;

-(void) showTabBar:(BOOL) show;

@end
