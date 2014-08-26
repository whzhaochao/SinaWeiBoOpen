//
//  RightViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "RightViewController.h"
#import "SendViewController.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAction:(UIButton*)sender {
    switch (sender.tag) {
        case 100:
            NSLog(@"发微博");
  
            SendViewController *sendCtrl=[[SendViewController alloc] init];
            MainViewController *sendNav=[[BaseNavigationController alloc] initWithRootViewController:sendCtrl];
            [self.appDelegate.menuCtrl presentViewController:sendNav animated:YES completion:^{
                NSLog(@"进入");
            }];
            break;
        case 101:
            NSLog(@"拍照");
            break;
        case 102:
            NSLog(@"图片");
            break;
        case 103:
            NSLog(@"其它");
            break;
        case 104:
            NSLog(@"位置");
            break;

        default:
            break;
    }
    
 
}
@end
