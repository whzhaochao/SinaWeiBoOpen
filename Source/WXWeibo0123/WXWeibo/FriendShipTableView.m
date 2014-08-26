//
//  FriendShipTableView.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-22.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "FriendShipTableView.h"
#import "FriendShipCellTableViewCell.h"

@implementation FriendShipTableView

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify=@"frinedcell";
    FriendShipCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell==nil) {
        cell=[[FriendShipCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.data= [self.data objectAtIndex:indexPath.row];
    cell.userInteractionEnabled=YES;
    
    return cell;
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}


@end
