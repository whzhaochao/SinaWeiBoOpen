//
//  NearByViewController.m
//  WXWeibo
//
//  Created by 赵超 on 14-8-21.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "NearByViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImageView+WebCache.h"
#import "DataService.h"

@interface NearByViewController ()

@end

@implementation NearByViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"我在这里";
        self.tableView.hidden=YES;
        [super showLoading:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    self.isCancelButton=YES;
    self.isBackButton=NO;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
//    locationManager.delegate=self;
//    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    [locationManager startUpdatingLocation];
//    
    [self getLoacationData];
}
//加载数据完成
-(void) loadDataFinis:(id)result{
    self.tableView.hidden=NO    ;
    [super showLoading:NO];
    
    NSArray *pois=[result objectForKey:@"pois"];
    self.data=pois;
    
    [self.tableView reloadData];
      NSLog(@"%@",result);
}

-(void) getLoacationData{
    if (self.data==nil) {
        
       float longitude= 120.3591060000;
        float  latitude=30.3184870000;

        NSString *longStr=[NSString stringWithFormat:@"%f",longitude];
        NSString *latistr=[NSString stringWithFormat:@"%f",latitude];
        
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     longStr,@"long",
                                     latistr,@"lat"
                                     , nil];
        
        //sina
        [self.sinaweibo requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"GET"
                                 block:^(id result){
                                     
                                     [self loadDataFinis:result];
                                 }];
        
//        [DataService requestWithUrl:@"place/nearby/pois.json" parmas:params httpMethod:@"GET" completeBlock:^(id result) {
//            [self loadDataFinis:result];
//        }];
        
    }
}


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    [manager stopUpdatingLocation];
    if (self.data==nil) {
        
        
        float longitude= newLocation.coordinate.longitude;
        float  latitude=newLocation.coordinate.latitude;
        NSString *longStr=[NSString stringWithFormat:@"%f",longitude];
        NSString *latistr=[NSString stringWithFormat:@"%f",latitude];
        
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     longStr,@"long",
                                     latistr,@"lat"
                                     , nil];
        [self.sinaweibo requestWithURL:@"place/nearby/pois.json" params:params httpMethod:@"GET"
                                 block:^(id result){
                                   
                                     [self loadDataFinis:result];
        }];
        
    }
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString* identify=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    NSDictionary *dic=[self.data objectAtIndex:indexPath.row];
    NSString *title=[dic objectForKey:@"title"];
    NSString *address=[dic objectForKey:@"address"];
    NSLog(@"%@",address);
    NSString *icon=[dic objectForKey:@"icon"];
    
     cell.textLabel.text=title;
     cell.detailTextLabel.text=address;
    [cell.imageView setImageWithURL:[NSURL URLWithString:icon]];
    
    
    return cell;
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}
//选中位置
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=[self.data objectAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.selectBlock!=nil) {
              self.selectBlock(dic);
        }
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
