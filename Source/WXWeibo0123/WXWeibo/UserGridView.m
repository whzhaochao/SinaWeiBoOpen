//
//  UserGridView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserGridView.h"
#import "UIButton+WebCache.h"
#import "UserViewController.h"

@implementation UserGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       UIView *gridView=   [[[NSBundle mainBundle]loadNibNamed:@"UserGridView" owner:self options:nil] lastObject];
         self.size=gridView.size;
            [self addSubview:gridView];
        gridView.backgroundColor=[UIColor clearColor];
        UIImage *image=[UIImage imageNamed:@"user_background"];
        UIImageView *backgroundView=[[UIImageView alloc]     initWithImage:image];
        backgroundView.frame=self.bounds;
      //  [self insertSubview:backgroundView atIndex:0];
        
   
      
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    //昵称
    self.nickName.text=self.userModel.screen_name;
    //粉丝数
    long fan=[_userModel.followers_count longLongValue];
    NSString *fans=[NSString stringWithFormat:@"%ld",fan];
    if (fan>10000) {
        fan=fan/10000;
        fans=[NSString stringWithFormat:@"ld万",fan];
    }
    self.funsNum.text=fans;
    
    //用户头像
    NSString *userUrl=_userModel.profile_image_url;
    NSURL *url=[NSURL URLWithString:userUrl];
    [self.userImage setImageWithURL:url];
    self.userImage.touchBlock=^{
        NSLog(@"aaaa");
    };
    self.userInteractionEnabled=YES;
    self.userImage.userInteractionEnabled=YES;
    UIGestureRecognizer *gest=[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction)];
    [self addGestureRecognizer:gest];
    
    
}

-(void)imageAction{
    UserViewController *userCtrl=[[UserViewController alloc] init];
    userCtrl.userInfo=_userModel;
    [self.viewController.navigationController pushViewController:userCtrl animated:YES];
    
}



-(void)dealloc {

    [_userImage release];
    [_nickName release];
    [_funsNum release];
    [super dealloc];
}


@end
