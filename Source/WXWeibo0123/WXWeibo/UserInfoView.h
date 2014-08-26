//
//  UserInfoView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RectButton.h"
#import "UserModel.h"

@interface UserInfoView : UIView{
    
}

@property (nonatomic,retain) UserModel *user;

@property (retain, nonatomic) IBOutlet UIImageView *userImage;
@property (retain, nonatomic) IBOutlet UILabel *userNickName;
@property (retain, nonatomic) IBOutlet UILabel *userInfo;
@property (retain, nonatomic) IBOutlet UILabel *userdetail;
@property (retain, nonatomic) IBOutlet UILabel *totalCount;
@property (retain, nonatomic) IBOutlet RectButton *funcBtn;
@property (retain, nonatomic) IBOutlet RectButton *friendsBtn;
@property (retain, nonatomic) IBOutlet RectButton *userMore;
- (IBAction)userInfoMationAction:(id)sender;
- (IBAction)userMoreAction:(id)sender;

@property (retain, nonatomic) IBOutlet RectButton *userImfoMation;

- (IBAction)userFriendAction:(id)sender;
- (IBAction)userFans:(id)sender;
- (IBAction)userMoreAction:(id)sender;

@end
