//
//  MessageViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MessageViewController.h"
#import "FaceView.h"
#import "FaceScrollView.h"
#import "UIFactory.h"
#import "DataService.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"消息";
    }
    return self;
}
-(void) messageAction:(UIButton*)btn{
    switch (btn.tag) {
        case 10:
               [self loadWeiboatData];
        case 11:
            NSLog(@"私信");
        case 12:
            NSLog(@"信息");
        case 13:
            NSLog(@"通知");
            break;
            
        default:
            break;
    }
}


-(void)_initViews{
    _weiboTable=[[WeiBoTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44-49) style:UITableViewStylePlain];
    _weiboTable.eventDelegate=self;
    _weiboTable.hidden=YES;
    [self.view addSubview:_weiboTable];
    
    NSArray *buttons=@[
                        @"my_info_0.png",
                        @"my_info_1.png",
                        @"my_info_2.png",
                        @"my_info_3.png",
                       
                       ];
    
    UIView *titleView=[[UIView alloc ] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    for (int i=0; i<buttons.count; i++) {
        NSString *imageName=[buttons objectAtIndex:i];
        UIButton *button=[UIFactory createButton:imageName highlighted:imageName];
        button.tag=10+i;
        button.showsTouchWhenHighlighted=YES;
        button.frame=CGRectMake(50*i, 10, 22, 22);
        [button addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    self.navigationItem.titleView=titleView;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //测试
//    FaceView *face=[[FaceView alloc] initWithFrame:CGRectMake(0, 0, 320*4 , 200)] ;
//    UIScrollView *sv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 250)];
//    sv.backgroundColor=[UIColor grayColor];
//    sv.contentSize=CGSizeMake(face.width, face.height);
//    sv.pagingEnabled=YES;
//    [sv addSubview:face];
//    [self.view addSubview:sv];
    
//    FaceScrollView *face=[[FaceScrollView alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
//    [self.view addSubview:face];
    
    [self _initViews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadatWeiboDataFinish:(NSDictionary *) result{
    
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *statuesDic in statues) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        [weibos addObject:weibo];
        [weibo release];
    }
    //刷新UI
    _weiboTable.hidden=NO;
    [super showLoading:NO];
    
    _weiboTable.data=weibos;
    [_weiboTable reloadData];
    
}

-(void) loadWeiboatData{
    [super showLoading:YES];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:@"10" forKey:@"count"];
    
    [self.sinaweibo requestWithURL:@"statuses/mentions.json" params:params httpMethod:@"GET" block:^(id result) {
        [self loadatWeiboDataFinish:result];
    }];

    
}
//下拦
-(void) pullDown:(BaseTableView*) tableView{
    
}
//上拦
-(void) pullUp:(BaseTableView*) tableView{
    
}
//选中
-(void) tableView:(BaseTableView*) tableView selectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
