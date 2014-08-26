//
//  MyImageView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(void);

@interface MyImageView : UIImageView

@property (nonatomic,copy) ImageBlock touchBlock;

@end
