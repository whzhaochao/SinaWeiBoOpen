//
//  BrowModeController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BrowModeController.h"

@interface BrowModeController ()

@end

@implementation BrowModeController

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
    // Do any additional setup after loading the view from its nib.
    self.title=@"图片浏览模式";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row==0) {
        cell.textLabel.text=@"大图";
        cell.detailTextLabel.text=@"所有网络加载大图";
    }else if(indexPath.row==1){
        cell.textLabel.text=@"小图";
        cell.detailTextLabel.text=@"所有网络加载小图";
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int mode=smallBrowMode;
    if (indexPath.row==0) {
        mode=LargeBrowMode;
    }else if (indexPath.row==1){
        mode=smallBrowMode;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:mode forKey:kBrowMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
 
    [self.navigationController popViewControllerAnimated:YES];
    //发送通知刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadWeiboTableNofication object:nil];

  
}
- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
