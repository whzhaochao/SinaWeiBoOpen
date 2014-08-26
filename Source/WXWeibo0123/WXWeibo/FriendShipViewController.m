//
//  FriendShipViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FriendShipViewController.h"
#import "UserModel.h"

@interface FriendShipViewController ()

@end

@implementation FriendShipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"关注";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data=[NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [self loadUserATData];
}

/**
    [
    [1],[2],[3]
 
        ]
 
 *
 */
-(void)loadUserAtDatafinish:(NSDictionary*) result{
    NSArray *userArray=[result objectForKey:@"users"];
    NSMutableArray *array2D=nil;
    for (int i=0; i<userArray.count; i++) {
        if (i%3==0) {
            array2D=[NSMutableArray arrayWithCapacity:3];
            [self.data addObject:array2D];
        }
        
        NSDictionary *userDic=[userArray objectAtIndex:i];
        UserModel *useMode=[[UserModel alloc] initWithDataDic:userDic];
        [array2D addObject:useMode];
    }
    
    self.tableView.data=self.data;
    [self.tableView reloadData];
}


//加载关注列表
-(void) loadUserATData{



    NSDictionary *authData= [[NSUserDefaults standardUserDefaults ] objectForKey:@"SinaWeiboAuthData"];
    self.userId=[ authData objectForKey:@"UserIDKey"];
    if (self.userId.length==0) {
        NSLog(@"userId为空");
        return;
    }
    
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:self.userId forKey:@"uid"];
    [params setObject:@"90" forKey:@"count"];
   
    
    [self.sinaweibo requestWithURL:self.urlString params:params httpMethod:@"GET" block:^(id result) {
        NSLog(@"%@",result);
        [self loadUserAtDatafinish:result];
    }];
    
    
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
@end
