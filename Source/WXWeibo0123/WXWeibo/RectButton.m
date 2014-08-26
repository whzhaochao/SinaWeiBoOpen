//
//  RectButton.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "RectButton.h"

@implementation RectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

-(void) setSubTitle: (NSString*)title subTitle:(NSString*)subTitle{
    
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
    titleLabel.text=title;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UILabel *subLable=[[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
    subLable.textAlignment=NSTextAlignmentCenter;
    subLable.text=subTitle;
    [self addSubview:subLable];
    [self addSubview:titleLabel];
}



-(void) layoutSubviews{
   // _rectTitleLable.text=self.title;
   // subTitleLabe.text=self.subTitle;
}



@end
