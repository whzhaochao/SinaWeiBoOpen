//
//  UserGridView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "MyImageView.h"
@interface UserGridView : UIView{
    
    
}

@property (nonatomic,retain) UserModel *userModel;

@property (retain, nonatomic) IBOutlet UILabel *nickName;


@property (retain, nonatomic) IBOutlet UILabel *funsNum;

@property (retain, nonatomic) IBOutlet MyImageView *userImage;

@end
