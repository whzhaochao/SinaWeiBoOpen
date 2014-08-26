//
//  CommentCell.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CommentCell.h"
#import "RTLabel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    _userImage=(UIImageView*) [self viewWithTag:100];
    _nickLabel=(UILabel*) [self viewWithTag:101];
    _timeLabel=(UILabel*) [self viewWithTag:102];
    
    _contentLabel=[[RTLabel alloc] initWithFrame:CGRectMake(_userImage.right+10, _nickLabel.bottom+5, 240, 21)];
    
    _contentLabel.font=[UIFont systemFontOfSize:14.0f];
    //十进制RGB值：r:69 g:149 b:203
    //十六进制RGB值：4595CB
    //设置链接的颜色
    _contentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置链接高亮的颜色
    _contentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    _contentLabel.delegate=self;
    [self.contentView addSubview:_contentLabel];
    
    
}
-(void) layoutSubviews{
    [super layoutSubviews];
    //评论头像
     NSString *url=self.commentModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:url]];
    //用户名
    _nickLabel.text=self.commentModel.user.screen_name;
    //发部时间
    _timeLabel.text=[UIUtils fomateString:self.commentModel.created_at];
    //评论内部
    _contentLabel.text=[UIUtils paraseLink:self.commentModel.text];
    _contentLabel.height=_contentLabel.optimumSize.height;
    
    
}
+(float) getCommentHeigt:(CommentModel *)model{
    RTLabel *rt=[[RTLabel alloc] initWithFrame:CGRectMake(0,0,240,0)];
    rt.font=[UIFont systemFontOfSize:14.0f];
    rt.text=model.text;
    rt.height=rt.optimumSize.height;
    
    return rt.optimumSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -delegat
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    NSLog(@"%@",url);
}

@end
