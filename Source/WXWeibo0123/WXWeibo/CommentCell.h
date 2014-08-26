//
//  CommentCell.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "CommentModel.h"
#import "MyImageView.h"

@interface CommentCell : UITableViewCell<RTLabelDelegate>{
    MyImageView *_userImage;
    UILabel   *_nickLabel;
    UILabel   *_timeLabel;
    RTLabel   *_contentLabel;
}


@property (nonatomic,retain) CommentModel *commentModel;

+(float) getCommentHeigt:(CommentModel*) model;


@end
