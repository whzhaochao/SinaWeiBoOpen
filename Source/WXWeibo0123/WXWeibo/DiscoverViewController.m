//
//  DiscoverViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearWeibMapViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"广场";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nearPersonBtn.layer.shadowColor=[UIColor blackColor].CGColor;
    self.nearPersonBtn.layer.shadowOffset=CGSizeMake(3, 3);
    self.nearPersonBtn.layer.shadowOpacity=1;
    self.nearPersonBtn.layer.shadowRadius=3;
    
    self.neaWeiBoBtn.layer.shadowColor=[UIColor blackColor].CGColor;
    self.neaWeiBoBtn.layer.shadowOffset=CGSizeMake(3, 3);
    self.neaWeiBoBtn.layer.shadowOpacity=1;
    self.neaWeiBoBtn.layer.shadowRadius=3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_neaWeiBoBtn release];
    [_nearPersonBtn release];
    [super dealloc];
}
- (IBAction)nearWeiBoAction:(id)sender {
    NSLog(@"附近的微博");
    NearWeibMapViewController *weibo=[[NearWeibMapViewController alloc] init];
    
    [self.navigationController pushViewController:weibo animated:YES];
    
    
}



- (IBAction)newPersonAction:(id)sender {
    NSLog(@"附近的人");
}
@end
