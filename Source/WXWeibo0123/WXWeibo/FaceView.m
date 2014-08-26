//
//  FaceView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FaceView.h"
#define Item_width 43
#define Item_height 45


@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initData];
        self.pageNumber=items.count;
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}



-(void) _initData{
    
    
    items=[[NSMutableArray alloc] init];
    //整理表情
    NSString *filepath=[[NSBundle mainBundle] pathForResource:@"_expression_cn" ofType:@"plist"];
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:filepath];
    

    NSMutableArray *items2D=nil;
    int i=0;
    NSEnumerator *enumerator = [dic keyEnumerator];
    id key;
    
    while ((key = [enumerator nextObject]))
    {
    
        /* code that uses the returned key */
        NSDictionary *item=[NSDictionary dictionaryWithObject:[dic objectForKey:key] forKey:key];
        if (i%28==0) {
            items2D=[NSMutableArray arrayWithCapacity:28];
            [items addObject:items2D];
        }
        [items2D addObject:item];
        i++;
        
    }
    
    //设置尺寸
    self.width=items.count*320;
    self.height=4*Item_height;
    //放大镜
    bigFace=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
    bigFace.image=[UIImage imageNamed:@"big_face.png"];
    bigFace.hidden=YES;
    bigFace.backgroundColor=[UIColor clearColor];
    [self addSubview:bigFace];
    UIImageView *faceItem=[[UIImageView alloc] initWithFrame:CGRectMake((64-30)/2, 15, 30, 30)];
    faceItem.tag=2013;
    faceItem.backgroundColor=[UIColor clearColor];
    [bigFace addSubview:faceItem];
    
    
    
    
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    int row=0,colum=0;
    int count=0;
    for (int i=0; i<items.count; i++) {
        NSArray *items2D=[items objectAtIndex:i];
        for (int j=0; j<items2D.count; j++) {
            NSDictionary *imageName=[items2D objectAtIndex:j];
            
            NSEnumerator *enumerator = [imageName keyEnumerator];
            id key;
            while ((key = [enumerator nextObject]))
            {
                CGRect frame=CGRectMake(colum*Item_width+15 , row*Item_height+15, 30, 30);
                //加前几页宽度
                float x=(i*320)+frame.origin.x;
                frame.origin.x=x;
                UIImage *image=[UIImage imageNamed:key];
                [image drawInRect:frame];

            }
         //   NSLog(@"%d %d %d %d",i,j,row,colum);
            NSLog(@"%d",count++);
            
            //更新行与列
            colum++;
            if (colum%7==0) {
                row++;
                colum=0;
            }
            if (row==4) {
                row=0;
            }
            
        }
    }
    
    
}
-(int) touchFace:(CGPoint ) point{
    int page=point.x/320;
    int colum=(point.x-(page*320)-15)/(Item_width);
    int row=(point.y-15)/(Item_height);
    int index=page*28+row*7+colum;
    if (page>3) {
        page=3;
    }
    if (row>3) {
        row=3;
    }
    if (colum>6) {
        colum=6;
    }
  
    
    NSArray* item=[items objectAtIndex:page];
    NSArray* item2d=[item objectAtIndex:row*7+colum];
    NSString *imageName=@"";
    NSEnumerator *enumerator = [item2d keyEnumerator];
    id key;
    while ((key = [enumerator nextObject]))
    {
        imageName=key;
    }
    if (![imageName  isEqualToString:_selectFaceName ] ) {
        UIImage *image=[UIImage imageNamed:imageName];
        _selectFaceName=imageName;
        UIImageView *faceitem=[bigFace viewWithTag:2013];
        faceitem.image=image;
    }
    
    //调整位置
    bigFace.left=(page*320)+colum*Item_width;
    bigFace.bottom=row*Item_height+30;
    
    
    NSLog(@"%@",item2d);
    
    return index;
}

//touchg事件
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    bigFace.hidden=NO;
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    [self touchFace:point];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollview=self.superview;
        scrollview.scrollEnabled=NO;
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    bigFace.hidden=YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollview=self.superview;
        scrollview.scrollEnabled=YES;
    }
    //调用block
    if (self.selectBlock!=nil) {
        self.selectBlock(_selectFaceName);
    }
    
    
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    [self touchFace:point];
    
}

@end
