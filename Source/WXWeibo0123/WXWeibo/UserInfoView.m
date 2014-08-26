//
//  UserInfoView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserInfoView.h"
#import "UIImageView+WebCache.h"
#import "FriendShipViewController.h"

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *userInfoView=[[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
        [self addSubview: userInfoView];
        
    }
    return self;
}


-(void) layoutSubviews{
    [super layoutSubviews];
    //头像
    NSString *url=self.user.avatar_large;
    
    
    [self.userImage setImageWithURL:[NSURL URLWithString:url]];
    //昵称
    self.userNickName.text=self.user.screen_name;
    //性别
    NSString *gender=_user.gender;
    NSString *sexName=@"未知";
    if ([gender isEqualToString:@"f"]) {
        sexName=@"女";
    }else if([gender isEqualToString:@"m"]){
        sexName=@"男";
    }
    sexName=[sexName stringByAppendingFormat:@"  %@ ",_user.location];
    
    self.userInfo.text=sexName;
  //  self.userInfo.text=[NSString stringWithFormat:"%@ %@ ",sexName,_user.location];
    //简介
    self.userdetail.text=_user.description;
    //微博数
    self.totalCount.text=[NSString stringWithFormat:@"共%@条微博",[_user.statuses_count stringValue]] ;
    //粉丝数
    long friL=[self.user.followers_count longValue];
    NSString *fris=[NSString stringWithFormat:@"%ld",friL];
    if (friL>=10000) {
        fris=[NSString stringWithFormat:@"%ld万",friL/10000];
    }
    [self.funcBtn setSubTitle:@"粉丝" subTitle:fris ];

    //关注数
    NSString* gzlong=[self.user.friends_count stringValue];
    [self.friendsBtn setSubTitle:@"关注" subTitle:gzlong];;

    //资料
    [self.userImfoMation setTitle:@"资料" forState:UIControlStateNormal];
    [self.userImfoMation setSubTitle:@"资料" subTitle:@""];
    //更多
    [self.userMore setTitle:@"更多" forState:UIControlStateNormal];
    [self.userMore setSubTitle:@"更多" subTitle:@""];
    
    
    
    
}

- (void)dealloc {
    [_userImage release];
    [_userNickName release];
    [_userInfo release];
    [_userdetail release];
    [_totalCount release];
    [_funcBtn release];
    [_friendsBtn release];
    [_userImfoMation release];
    [_userMore release];
    [super dealloc];
}
- (IBAction)userFriendAction:(id)sender {
    
    NSLog(@"user头油");
    
    FriendShipViewController *friendCtrl=[[FriendShipViewController alloc] init];
    friendCtrl.userId=self.user.idstr;
    friendCtrl.urlString=@"friendships/friends.json";
    [self.viewController.navigationController pushViewController:friendCtrl animated:YES];
    
    
}

- (IBAction)userFans:(id)sender {
    
    FriendShipViewController *friendCtrl=[[FriendShipViewController alloc] init];
    friendCtrl.userId=self.user.idstr;
    friendCtrl.urlString=@"friendships/followers.json";
    
    [self.viewController.navigationController pushViewController:friendCtrl animated:YES];
    
    
    NSLog(@"粉丝");
    
}

- (IBAction)userMoreAction:(id)sender {
      NSLog(@"更多");
}
- (IBAction)userInfoMationAction:(id)sender {
    NSLog(@"资料");
}


@end
