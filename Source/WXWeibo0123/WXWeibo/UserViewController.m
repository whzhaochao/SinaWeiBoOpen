//
//  UserViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "WeiboModel.h"
#import "UIFactory.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"%@",_userName);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _requests=[[NSMutableArray alloc] init];
    
    [self loadUserData];
    [self loadUserWeiboData];
    self.title=@"个人资料";
    // Do any additional setup after loading the view from its nib.
     self.userView=[[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    //代理方法
    self.tableView.eventDelegate=self;
    //回到首页
    UIButton *homeBtn=[UIFactory createButtonWithBackground:@"tabbar_home.png" backgroundHighlighted:@"tabbar_home_highlighed.png"];
    
    homeBtn.frame=CGRectMake(0, 0, 34, 27);
    [homeBtn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *homeItem=[[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem=homeItem;
}
-(void) goHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
#pragma mark -loadData

//加载用户资料
-(void) loadUserData{
    if (self.userName.length==0) {
        return;
    }else{
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSString *userName=self.userName;
        NSRange range=[userName rangeOfString:@"://@"];
        userName =[userName substringFromIndex:range.location+4];

    
        [params setObject:userName  forKey:@"screen_name"];
        
      SinaWeiboRequest *reuquest=  [self.sinaweibo requestWithURL:@"users/show.json"
                                params:params
                            httpMethod:@"GET"
                                 block:^(id result){
                                     [self loadDataFinish:result];
                                 }];
        [_requests addObject:reuquest];
    }
    

}
//完成数据加载
-(void) loadDataFinish:(id) result{
    
    UserModel *userModel=[[UserModel alloc] initWithDataDic:result];
    NSLog(@"%@=====",userModel.followers_count);
    
    self.userInfo=userModel;
    self.userView.user=userModel;
    self.tableView.tableHeaderView=self.userView;
}



//加载用户微博
-(void) loadUserWeiboData{
    if (self.userName.length==0) {
        return;
    }else{
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSString *userName=self.userName;
        NSRange range=[userName rangeOfString:@"://@"];
        userName =[userName substringFromIndex:range.location+4];
        [params setObject:@"赵侠客"  forKey:@"screen_name"];
        [params setObject:@"10" forKey:@"count"];
        NSLog(@"userName=%@",userName);
        
        
        
        SinaWeiboRequest *reuquest= [self.sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                params:params
                            httpMethod:@"GET"
                                 block:^(id result){
                                     [self loadUserWeiboDataFinish:result];
                                 }];
        [_requests addObject:reuquest];
    }
    
    
}
//完成数据加载
-(void) loadUserWeiboDataFinish:(id) result{
    NSLog(@"%@",result);
    NSArray *statuse=[result objectForKey:@"statuses"];
    NSMutableArray * weibos=[NSMutableArray arrayWithCapacity:statuse.count];
    for (NSDictionary *dic in statuse ) {
        WeiboModel *weibo=[[WeiboModel alloc] initWithDataDic:dic];
        [weibos addObject:weibo];
    }
    self.tableView.data=weibos;
    if (weibos.count>=20) {
        self.tableView.isMore=YES;
    }else {
        self.tableView.isMore=NO;
    }
    [self.tableView reloadData];
}

//下拦
-(void) pullDown:(BaseTableView*) tableView{
    [tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2];
}
//上拦
-(void) pullUp:(BaseTableView*) tableView{
    [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (SinaWeiboRequest *request in _requests) {
        //取消请求
        [request disconnect];
    }
}

@end
