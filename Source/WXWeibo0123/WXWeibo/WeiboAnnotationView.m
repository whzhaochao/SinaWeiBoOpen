//
//  WeiboAnnotationView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-25.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiBoAnnotation.h"
#import "UserModel.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

-(id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return  self;
}

-(void) initView{
    _userImage=[[UIImageView alloc] initWithFrame:CGRectZero];
    _userImage.layer.borderColor=[UIColor whiteColor].CGColor;
    _userImage.layer.borderWidth=1;
    _weiboImage=[[UIImageView alloc] initWithFrame:CGRectZero];
    _weiboImage.backgroundColor=[UIColor blackColor];
    
    _textLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    _textLabel.font=[UIFont systemFontOfSize:10];
    _textLabel.numberOfLines=3;
    _textLabel.backgroundColor=[UIColor whiteColor];
    

    [self addSubview:_weiboImage];
    [self addSubview:_textLabel];
        [self addSubview:_userImage];
    
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    WeiBoAnnotation *anno=self.annotation;
    if ([anno isKindOfClass:[WeiBoAnnotation class]]) {
        WeiboModel *weiModel=anno.weiboModel;
        NSString* imageString=weiModel.thumbnailImage;
        if (imageString.length>0) {
           //带图片
            _weiboImage.frame=CGRectMake(15, 15, 90, 90);
            [_weiboImage setImageWithURL:[NSURL URLWithString:imageString]];
            _userImage.frame=CGRectMake(70, 70, 30, 30);
            [_userImage setImageWithURL:[NSURL URLWithString:weiModel.user.profile_image_url]];
            _textLabel.hidden=YES;
            _weiboImage.hidden=NO;
        }else{
            //不带图片
            _userImage.frame=CGRectMake(20, 20, 40, 40);
             [_userImage setImageWithURL:[NSURL URLWithString:weiModel.user.profile_image_url]];
        }
        _textLabel.frame=CGRectMake(_userImage.right+5, _userImage.top, 110, 45);
        _textLabel.text=weiModel.text;
        _textLabel.hidden=NO;
        _weiboImage.hidden=YES;
        
    }
    
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
