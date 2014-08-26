//
//  FaceView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBock)(NSString* faceName);


@interface FaceView : UIView{
    NSMutableArray * items;
    UIImageView    *bigFace;
}

@property (nonatomic,copy) NSString* selectFaceName;

@property (nonatomic,assign) NSInteger pageNumber;

@property (nonatomic,copy) SelectBock selectBlock;

@end
