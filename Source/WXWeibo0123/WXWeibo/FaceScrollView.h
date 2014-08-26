//
//  FaceScrollView.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"

@interface FaceScrollView : UIView<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    FaceView     *faceView;
    UIPageControl *pageCtrl;
}


-(id) initwithSelectBlock:(SelectBock)block frame:(CGRect) frame;

-(void) setSelectBlock:(SelectBock) block;


@end
