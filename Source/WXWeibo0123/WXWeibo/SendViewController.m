//
//  SendViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-21.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "SendViewController.h"
#import "UIFactory.h"
#import "NearByViewController.h"
#import "BaseNavigationController.h"
#import "DataService.h"

@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShowNocification:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}
-(void)cancleActoin{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消");
}


#pragma mark-data
//发送成功
-(void) sendresult{
    
    [super showStatusTip:NO     title:@"发送成功！"];
    
    
    [self cancleActoin];
}


-(void)sendActoin{
    
    [super showStatusTip:YES title:@"发送中..."];
    
    NSString *test=self.textView.text;
    if (test.length==0) {
        return;
    }
    NSMutableDictionary *parmas=[NSMutableDictionary dictionaryWithObject:test forKey:@"status"];
    
    if (self.longitude.length>0) {
        [parmas setObject:self.longitude forKey:@"long"];
    }
    if (self.latitude.length>0) {
        [parmas setObject:self.latitude forKey:@"lat"];
    }
    //带图片
    if (self.sendImage!=nil) {
   
 
              [parmas setObject:self.sendImage forKey:@"pic"];
              [self.sinaweibo requestWithURL:@"statuses/upload.json" params:parmas httpMethod:@"POST"  block:^(id result  ){
                NSLog(@"%@",result);
                [self sendresult];
                
              }];
   
      //  NSData *data= UIImageJPEGRepresentation(self.sendImage, 0.3);
      
     
 
    //不带图
    }else{
    
        //自带httpRequest
        
//        [self.sinaweibo requestWithURL:@"statuses/update.json" params:parmas httpMethod:@"POST"  block:^(id result  ){
//            [self sendresult];
//        }];
        
        //自己
        [DataService requestWithUrl:@"statuses/update.json" parmas:parmas httpMethod:@"POST" completeBlock:^(id result) {
             [self result];
        }];
        
        
    }
    
    

    
    
    
}

- (void)viewDidLoad
{
    self.isCancelButton=YES;
    self.isBackButton=NO;
    
    [super viewDidLoad];
    self.title=@"发布新微博";
    // Do any additional setup after loading the view from its nib.
      [self _initView];

//    
//    UIButton *button=[ UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(cancleActoin)];
//    UIBarButtonItem *cancleButton=[[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem=cancleButton;
    
    UIButton *send=[ UIFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"发送" target:self action:@selector(sendActoin)];
    UIBarButtonItem *sendButton=[[UIBarButtonItem alloc] initWithCustomView:send];
    self.navigationItem.rightBarButtonItem  =sendButton;
}
//定位
-(void) location{
    NearByViewController* nearBy=[[NearByViewController alloc] init];

    BaseNavigationController *baseNav=[[BaseNavigationController alloc] initWithRootViewController:nearBy];
    [self presentModalViewController:baseNav animated:YES];
    nearBy.selectBlock=^(NSDictionary *dic){
        self.longitude=[dic objectForKey:@"lon"];
        self.latitude=[dic objectForKey:@"lat"];
        
        NSString *address=[dic objectForKey:@"address"];
        if ([address isKindOfClass:[NSNull class]] || address.length==0) {
            address=[dic objectForKey:@"title"];
        }
        self.placeLabel.text=address;
        self.placeView.hidden=NO;
        UIButton *btn=[self.editBar viewWithTag:10 ];
        btn.selected=YES;
       
    };
}
//使用照片
-(void) selectImageSend{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [actionSheet showInView:self.view];
    
}
#pragma mark -actionsheet delegat
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex) {
        case 0:
            NSLog(@"拍照!");
            BOOL hasCarm=[UIImagePickerController isCameraDeviceAvailable:   UIImagePickerControllerCameraDeviceRear] ||[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
            if (hasCarm) {
                sourceType=UIImagePickerControllerSourceTypeCamera;
            }else{
               UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                return ;
            }
    
 
            
            break;
        case 1:
            NSLog(@"相册!");
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            NSLog(@"取消!");
            return ;
            break;
        default:
            break;
    }
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.sourceType=sourceType;
    imagePicker.delegate=self;
  
    [self presentModalViewController:imagePicker animated:YES];
    
    

}
//
-(void) scaleImageAction:(UITapGestureRecognizer*) top{
    NSLog(@"缩小图片");
    
       UIButton *btn=[_fullImageView viewWithTag:100];

        btn.hidden=YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        _fullImageView.frame=CGRectMake(5, ScreenHeight-260, 20, 20);
        
    }completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
        [UIApplication sharedApplication].statusBarHidden=NO;
    }];
}

//删除图片
-(void) deleteImage:(UIButton *)btn{
   
    
    [self scaleImageAction:nil];
    
    [self.sendImageButton removeFromSuperview];
     self.sendImage=nil;
     btn.hidden=YES;
    UIButton *btn1= [self.editBar viewWithTag:10];
    UIButton *btn2=[self.editBar  viewWithTag:11 ];
    [UIView animateWithDuration:0.5 animations:^{
        btn1.transform=CGAffineTransformIdentity;
        btn2.transform=CGAffineTransformIdentity;
    }];
    
    
    NSLog(@"删除图片");
}

//点击图片放大
-(void) imageAction:(UIButton*)btn{
    NSLog(@"放大图片");
    //键盘消失
    [self.textView resignFirstResponder];
    if (_fullImageView==nil) {
        _fullImageView=[[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _fullImageView.backgroundColor=[UIColor blackColor];
        _fullImageView.userInteractionEnabled=YES;
        _fullImageView.contentMode=UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageAction:)];
        [_fullImageView addGestureRecognizer:tapGesture];
    }
    //添加删除上传图片按钮
    UIButton *deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
    deleteButton.frame=CGRectMake(280, 40, 20, 20);
    deleteButton.tag=100;
    deleteButton.hidden=YES;
    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [_fullImageView addSubview:deleteButton];
    
    
    if (![_fullImageView superview]) {
        _fullImageView.image=self.sendImage;
        [self.view.window addSubview:_fullImageView];
        _fullImageView.frame=CGRectMake(5, ScreenHeight-240, 20, 20);
        
        [UIView animateWithDuration:0.5 animations:^{
            _fullImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);

        }completion:^(BOOL finished) {
            deleteButton.hidden=NO;
            
            [UIApplication sharedApplication].statusBarHidden=YES;
        }];
    }
    
    
}

//选择相册结束
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

     NSData *imageDate=  UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 1.0);
    self.sendImage=[UIImage imageWithData:imageDate];
    if (self.sendImageButton==nil) {
        self.sendImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sendImageButton.layer.cornerRadius=5;
        self.sendImageButton.layer.masksToBounds=YES;
        self.sendImageButton.frame=CGRectMake(5, 20, 25, 25);
        [self.sendImageButton addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self.sendImageButton setImage:self.sendImage forState:UIControlStateNormal];
    [self.editBar addSubview:self.sendImageButton];

    
    
    
    UIButton *btn1= [self.editBar viewWithTag:10];
    UIButton *btn2=[self.editBar  viewWithTag:11 ];
    

    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationDelay:0.5];
        btn1.transform=CGAffineTransformTranslate(btn1.transform, 30, 0);
        btn2.transform=CGAffineTransformTranslate(btn2.transform, 10, 0);
    }];
    
    
    
    NSLog(@"%@",@"选取照片成功");


    [picker dismissViewControllerAnimated:YES completion:nil];
}
//表情按钮
-(void) faceBroad{
    [self.textView resignFirstResponder];
    
    __block SendViewController *this=self;
    
    if (faceView==nil) {
//        faceView=[[FaceScrollView alloc] initwithSelectBlock:^(NSString *faceName) {
//            NSLog(@"%@",faceName);
//        } frame:CGRectMake(0, 200, 0, 0)];
        
        faceView=[[FaceScrollView alloc] initWithFrame:CGRectZero];
        [faceView setSelectBlock:^(NSString *faceName) {
            NSString* test=this.textView.text;
            NSString *appendText=[test stringByAppendingString:[NSString stringWithFormat:@"[%@]",faceName]];
            this.textView.text=appendText;
        }];
        
        faceView.top=ScreenHeight-20-44-faceView.height;
        faceView.transform=CGAffineTransformTranslate(faceView.transform, 0, ScreenHeight-44-20);
        [self.view addSubview:faceView];
        
    }
      UIButton *facebtn=[self.editBar viewWithTag:14];
    UIButton *keyBorad=[self.editBar viewWithTag:15];
    keyBorad.hidden=NO;
    keyBorad.alpha=0;
    faceView.alpha=1;
    
    [UIView animateWithDuration:0.3 animations:^{
        faceView.transform=CGAffineTransformIdentity;
        facebtn.alpha=0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            keyBorad.alpha=1;
        }];
        
    }];
    
    //调整text editbar y坐标
//    self.editBar.bottom=ScreenHeight-20-11-faceView.height;
//    self.textView.height=self.editBar.top;
}
//显示键盘
-(void) showKeyBroad{
    [self.textView becomeFirstResponder];
    UIButton *facebtn=[self.editBar viewWithTag:14];
    UIButton *keyBorad=[self.editBar viewWithTag:15];
    keyBorad.hidden=NO;
    keyBorad.alpha=1;
    faceView.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        faceView.transform=CGAffineTransformTranslate(facebtn.transform, ScreenHeight-44-20, 0);
        keyBorad.alpha=0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            facebtn.alpha=1;
        }];
        
    }];
    //调整text editbar y坐标

}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    [self showKeyBroad];
    return YES;
}


-(void) buttonAction:(UIButton*) btn{
    
    
    switch (btn.tag) {
        case 10:
            NSLog(@"地理位置");
            [self location];
            break;
        case 11:
            [self selectImageSend];
            break;
        case 12:
            NSLog(@"#");
            break;
        case 13:
            NSLog(@"@");
            break;
        case 14:
            NSLog(@"表情");
            [self faceBroad];
            break;
        case 15:
            NSLog(@"键盘");
            [self showKeyBroad];
            break;
        default:
            break;
    }
    

    
    
}

-(void)_initView{
    //显示键盘
    [self.textView becomeFirstResponder];
   // self.textView.delegate=self;
    
    NSArray* imageNames=@[@"send_icon_0.png",
                          @"send_icon_1.png",
                          @"send_icon_2.png",
                          @"send_icon_3.png",
                          @"send_icon_4.png",
                          @"keyBroad.png"
                          ];
    
    NSArray* imageHNames=@[@"send_icon_0_h.png",
                          @"send_icon_1.png",
                          @"send_icon_2.png",
                          @"send_icon_3.png",
                          @"send_icon_4.png",
                          @"keyBroad.png"
                           ];
    
    
    
    for (int i=0;i<imageNames.count;i++) {
        NSString *imagename=[imageNames objectAtIndex:i];
        NSString *imageHname=[imageHNames objectAtIndex:i];
        UIButton *button=[UIFactory createButton:imagename highlighted:imageHname];
        button.tag=10+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(20+(64*i), 25, 23, 19);
        [self.editBar addSubview:button];
        if (i==5) {
            button.hidden=YES;
            button.left-=64;
        }
        
    }
    

    
}
-(void) keyBoardShowNocification:(NSNotification *) notification{
    NSValue *keyValue= [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame=[keyValue CGRectValue];
    float height=frame.size.height;
    NSLog(@"%f",height);
    
    self.editBar.bottom=ScreenHeight-height-20-100;
    self.textView.height=self.editBar.top;
    self.textView.text=@"";
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textView release];
    [_editBar release];
    [_placeView release];
    [_placeBackView release];
    [_placeLabel release];
    [super dealloc];
}
@end
