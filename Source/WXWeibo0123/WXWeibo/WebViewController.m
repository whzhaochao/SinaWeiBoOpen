//
//  WebViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-20.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id) initWithUrl:(NSString *)url{
    self=[super init];
    if (self!=nil) {
        _url=[url copy];
    }
    return  self;
}
#pragma mark --Weibview delegae
//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString*title= [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title=title;
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    
    self.title=@"载入中...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (IBAction)reload:(UIBarButtonItem *)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (IBAction)goForward:(id)sender {
    [_webView reload];
}
- (void)dealloc {
    [_webView release];
    [super dealloc];
}
@end
