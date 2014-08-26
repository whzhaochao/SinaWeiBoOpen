//
//  CommentTabView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CommentTabView.h"
#import "CommentCell.h"
#import "CommentModel.h"

@implementation CommentTabView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -UIComenttableview



-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model=[self.data objectAtIndex:indexPath.row];
    return [CommentCell getCommentHeigt:model]+80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"CommentCell";
    CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject] ;
    }
    CommentModel *model=(CommentModel*)[self.data objectAtIndex:indexPath.row];
    NSLog(@"%@",model);
    cell.commentModel=model;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"aaaaaa");
}

//评论数
-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *commentCount=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    commentCount.backgroundColor=[UIColor clearColor];
    commentCount.font=[UIFont boldSystemFontOfSize:16.0f];
    commentCount.textColor=[UIColor blueColor];
    NSNumber *count=[self.commentDic objectForKey:@"total_number"];
    commentCount.text=[NSString stringWithFormat:@"评论数:%@",count ];
    UIImageView *separeView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 39, tableView.width, 1)];
    separeView.image=[UIImage imageNamed:@"userinfo_header_separator.png"];
    
    [view addSubview:separeView];

    [view addSubview:commentCount];
    return view;
    
}
-(float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

@end
