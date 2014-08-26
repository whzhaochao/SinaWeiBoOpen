//
//  WebViewController.h
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>{
    NSString *_url;
}

-(id) initWithUrl:(NSString*)url;

- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)reload:(UIBarButtonItem *)sender;
- (IBAction)goForward:(id)sender;
@property (retain, nonatomic) IBOutlet UIWebView *webView;



@end
