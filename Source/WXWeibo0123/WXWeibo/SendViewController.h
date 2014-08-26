//
//  SendViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-21.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import "FaceScrollView.h"

@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
   
    UIImageView *_fullImageView;
    
    FaceScrollView *faceView;
   
}



//send data
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIView *editBar;
//send image
@property (retain,nonatomic) UIImage *sendImage;

@property (retain,nonatomic) UIButton *sendImageButton;


@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (retain, nonatomic) IBOutlet UIView *placeView;
@property (retain, nonatomic) IBOutlet UIImageView *placeBackView;
@property (retain, nonatomic) IBOutlet UILabel *placeLabel;

@end
