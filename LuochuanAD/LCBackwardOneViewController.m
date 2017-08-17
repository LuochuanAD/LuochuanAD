//
//  LCBackwardOneViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LCBackwardOneViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MapLocationViewController.h"

@interface LCBackwardOneViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong)CLLocationManager *locationManager;
@end

@implementation LCBackwardOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc]initWithTitle:@"机位MapLocation" style:UIBarButtonItemStyleDone target:self action:@selector(pushToMapLocationViewController:)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];

    
    [self requestCurrentAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushToMapLocationViewController:(UIButton *)button{
    MapLocationViewController *mapLocationVC=[[MapLocationViewController alloc]init];
    [self.navigationController pushViewController:mapLocationVC animated:YES];
    
}

- (void)requestCurrentAddress{
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            self.locationManager=[[CLLocationManager alloc]init];
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
                [self.locationManager requestAlwaysAuthorization];
                [self.locationManager setDelegate:self];
                [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
                [self.locationManager setDistanceFilter:100];
                [self.locationManager startUpdatingLocation];
                [self.locationManager startUpdatingHeading];
            }
        }
    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"您没有开启定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}
#pragma mark --CLLocationManagerdelegate;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locationManager stopUpdatingLocation];
    CLLocation *location=locations.lastObject;
    [self reverseGeocoder:location];
}
- (void)reverseGeocoder:(CLLocation *)currentLocation{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error||placemarks.count==0) {
            NSLog(@"error:%@",error);
        }else{
            CLPlacemark *placemark=placemarks.firstObject;
            self.title=[[placemark addressDictionary] objectForKey:@"City"];
        }
    }];
}
@end
