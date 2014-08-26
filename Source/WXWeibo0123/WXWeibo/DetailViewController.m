//
//  DetailViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "CommentModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    [self _initView];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_userImageView release];
    [_nickLabel release];
    [_userBarView release];
    [super dealloc];
}

#pragma mark -init

-(void) _initView{
    UIView *tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    tableHeaderView.backgroundColor=[UIColor clearColor];
    //用户栏视图
    NSString *userImageUrl=_weiboModel.user.profile_image_url;
    
    self.userImageView.layer.cornerRadius=5;
    self.userImageView.layer.masksToBounds=YES;
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
    self.nickLabel.text=_weiboModel.user.screen_name;
    
    [tableHeaderView addSubview:self.userBarView];
    tableHeaderView.height+=60;
    
 
    //创建视图
    float h=[WeiboView getWeiboViewHeight:self.weiboModel isRepost:NO isDetail:YES];
    _weiboView=[[WeiboView alloc] initWithFrame:CGRectMake(10, _userBarView.bottom+10, ScreenWidth-20, h)];
    _weiboView.isDetail=YES;
    _weiboView.weiboModel=_weiboModel;
    [tableHeaderView addSubview:_weiboView];
     tableHeaderView.height+=h;
     self.tableView.tableHeaderView=tableHeaderView;
    //实现代理
    self.tableView.eventDelegate=self;
}

#pragma mark loadData

-(void) loadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    [params setObject:[_weiboModel.weiboId stringValue]  forKey:@"id"];
    [params setObject:@"20" forKey:@"count"];
 
    [self.sinaweibo requestWithURL:@"comments/show.json"
                            params:params
                        httpMethod:@"GET"
                             block:^(id result){
                                 [self loadDataFinish:result];
                             }];
}
//完成数据加载
-(void) loadDataFinish:(id) result{
    
    NSArray *arrays = [result objectForKey:@"comments"];
    
    NSMutableArray *comments=[NSMutableArray arrayWithCapacity:arrays.count];
    for (NSDictionary *dic in arrays) {
        CommentModel *commentModel=[[CommentModel alloc] initWithDataDic:dic];
        [comments addObject:commentModel];
    }
    if (arrays.count>=20) {
        self.tableView.isMore=YES;
    }else{
        self.tableView.isMore=NO;
    }
    
    self.tableView.data=comments;
    self.tableView.commentDic=result;
    [self.tableView reloadData];

    
}
#pragma mark delete
//下拦
-(void) pullDown:(BaseTableView*) tableView{
    NSLog(@"pullDown");
}
//上拦
-(void) pullUp:(BaseTableView*) tableView{
     NSLog(@"pullUp");
}
//选中
-(void) tableView:(BaseTableView*) tableView selectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"selectRowAtIndexPath");
}




@end
