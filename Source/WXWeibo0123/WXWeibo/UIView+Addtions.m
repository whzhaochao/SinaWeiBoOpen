//
//  UIView+Addtions.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIView+Addtions.h"

@implementation UIView (Addtions)

//
-(UIViewController*) viewController{
    
    UIResponder *next=[self nextResponder];
    do{
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)next;
        }
        next=[next nextResponder];
    }while(next!=nil);
    
    return nil;
    
}

@end
