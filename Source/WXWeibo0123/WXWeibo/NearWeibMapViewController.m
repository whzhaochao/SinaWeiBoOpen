//
//  NearWeibMapViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-25.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "NearWeibMapViewController.h"
#import "WeiboModel.h"
#import "WeiboAnnotationView.h"
#import "WeiBoAnnotation.h"

@interface NearWeibMapViewController ()

@end

@implementation NearWeibMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return  nil;
    }
    
    static NSString *identfy=@"weiboAnnotation";
    WeiboAnnotationView *anno=[mapView dequeueReusableAnnotationViewWithIdentifier:identfy];
    if (anno==nil) {
        anno=[[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identfy];
    }
    
    return anno;
    
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    for (UIView *view in views) {
        CGAffineTransform tranform=view.transform;
        view.transform=CGAffineTransformScale(tranform, 0.7, 0.7);
        view.alpha=0;
        [UIView animateWithDuration:0.5 animations:^{
            //动画2
            view.transform=CGAffineTransformScale(tranform, 1.2, 1.2);
            view.alpha=1;
        } completion:^(BOOL finished) {
            //动画2
            [UIView animateWithDuration:0.5 animations:^{
                view.transform=CGAffineTransformIdentity;
            }];
        }];
        
    }
    
    
    NSLog(@"ddd");
}
-(void) loadDataFinish:(id) result{
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    for (int i=0;i<statues.count;i++) {
        NSDictionary *statuesDic=[statues objectAtIndex:i];
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        [weibos addObject:weibo];
        [weibo release];
        
        WeiBoAnnotation *weiboAno=[[WeiBoAnnotation alloc] initWhitWeibo:weibo];
        //一个一个加上去
        [self.mapView performSelector:@selector(addAnnotation:) withObject:weiboAno afterDelay:i*0.05];
       // [self.mapView addAnnotation:weiboAno];
        
    }
    self.data=weibos;
    
    NSLog(@"%d",self.data.count);
    
    
    
    
}


-(void) loadWeiBOData{
    NSString* longitude=@"120.359106";
    NSString*  latitude=@"30.318487";
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:@"10" forKey:@"count"];
    [params setObject:longitude forKey:@"long"];
    [params setObject:latitude forKey:@"lat"];

    [self.sinaweibo requestWithURL:@"place/nearby_timeline.json" params:params httpMethod:@"GET" block:^(id result) {
        [self loadDataFinish:result];
    }];
    
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(30.318487, 120.359106);
	MKCoordinateSpan span={0.1,0.1};
    MKCoordinateRegion regin={center,span};
    [self.mapView setRegion:regin];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadWeiBOData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mapView release];
    [super dealloc];
}
@end
