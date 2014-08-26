//
//  FaceScrollView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FaceScrollView.h"

@implementation FaceScrollView

-(void)setSelectBlock:(SelectBock)block{
    faceView.selectBlock=block;
}

-(id) initwithSelectBlock:(SelectBock)block frame:(CGRect)frame{
    self=[self initWithFrame:frame];
    if (self!=nil) {
        faceView.selectBlock=block;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

-(void) _initView{
    faceView=[[FaceView alloc] initWithFrame:CGRectMake(0, 0, 320*4, 0)];
    faceView.backgroundColor=[UIColor grayColor];
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, faceView.height)];
    scrollView.contentSize=CGSizeMake(faceView.width, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.clipsToBounds=NO;
    scrollView.delegate=self;
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.pagingEnabled=YES;

    [scrollView addSubview:faceView];
    
    [self addSubview:scrollView];
    
    pageCtrl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.bottom, 40, 20)];
    pageCtrl.backgroundColor=[UIColor grayColor];
    pageCtrl.numberOfPages=faceView.pageNumber;
    pageCtrl.currentPage=0;
    [self addSubview:pageCtrl];
    
    self.height=scrollView.height+pageCtrl.height;
    self.width=scrollView.width;
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView1{
    int pageNumber=scrollView1.contentOffset.x/320;
    pageCtrl.currentPage=pageNumber;
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
