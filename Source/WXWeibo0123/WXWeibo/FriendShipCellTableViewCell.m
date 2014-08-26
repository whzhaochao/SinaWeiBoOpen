//
//  FriendShipCellTableViewCell.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FriendShipCellTableViewCell.h"
#import "UserGridView.h"

@implementation FriendShipCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initViews];
    }
    return self;
}


-(void) initViews{
    for (int i=0; i<3; i++) {
        UserGridView *gridView=[[UserGridView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        gridView.tag=10+i;
        [self.contentView addSubview:gridView];
    }
}

-(void) layoutSubviews{
    [super layoutSubviews];
    for (int i=0; i<self.data.count; i++) {
        UserModel *userModel=[self.data objectAtIndex:i];
        int tag=10+i;
        UserGridView *userGrid=[self.contentView viewWithTag:tag];
        userGrid.userModel=userModel;
        userGrid.frame=CGRectMake(100*i+10, 10, 100, 100);
        
    }
    
}

@end
