//
//  MapLocationViewController.m
//  LuochuanAD
//
//  Created by care on 17/4/19.
//  Copyright © 2017年 luochuan. All rights reserved.
//

//key :bd1a9bb8de2061db8e283827d76701ca

// 大头针实时更新位置[pointAnnotation setCoordinate:CLLocationCoordinate2DMake(22.65353,113.82064000000013)];


#import "MapLocationViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface MapLocationViewController ()<MAMapViewDelegate>
{
    SpreadButton *_spreadButton;
    BOOL _horizontal;
    NSArray *_titleArray;
    MAPointAnnotation *pointAnnotation;
    
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *flyAnnotations;
@property (nonatomic, strong) NSMutableArray *carAnnotations;
@end

@implementation MapLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AMapServices sharedServices].enableHTTPS=YES;
    self.mapView=[[MAMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate=self;
    [self.view addSubview:self.mapView];
    self.mapView.showsIndoorMap=YES;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(22.64343,113.82064000000003) animated:NO];
    [self.mapView setZoomLevel:17.5];
    [self createSpreadButtonSettings];
    [self initFlyAnnotations];
    [self initCarAnnotions];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mapView addAnnotations:self.flyAnnotations];
    [self.mapView addAnnotations:self.carAnnotations];
    
    
}
- (void)initFlyAnnotations{
    self.flyAnnotations=[NSMutableArray array];
    CLLocationCoordinate2D flyCoordinates[10]={
        {22.62343,113.82064000000003},
        {22.64313,113.81423030000003},
        {22.64323,113.81223030000003},
        {22.64343,113.82063060010003},
        {22.64243,113.82063050000003},
        {22.64143,113.82063040020003},
        {22.64043,113.82063030000003},
        {22.64383,113.81723010000003},
        {22.64373,113.81723050000003},
        {22.64363,113.81723040000003},
    };
    for (int i=0; i<10; ++i) {
        MAPointAnnotation *fly=[[MAPointAnnotation alloc]init];
        fly.coordinate=flyCoordinates[i];
        fly.title=[NSString stringWithFormat:@"航班号:mu99%d",i];
        fly.subtitle=[NSString stringWithFormat:@"(%f,%f)",flyCoordinates[i].latitude,flyCoordinates[i].longitude];
        [self.flyAnnotations addObject:fly];
    }


}
- (void)initCarAnnotions{
    self.carAnnotations=[NSMutableArray array];
    CLLocationCoordinate2D carCoordinates[10]={
        {22.64343,113.81903000000003},
        {22.64343,113.81813080000003},
        {22.64383,113.81723030000003},
        {22.64343,113.81623060010003},
        {22.64243,113.81543050000003},
        {22.64143,113.81453040020003},
        {22.64043,113.81363030000003},
        {22.64333,113.81273020000003},
        {22.64318,113.81183010000003},
        {22.64307,113.81093009000003},
    };
    for (int i=0; i<10; ++i) {
        MAPointAnnotation *car=[[MAPointAnnotation alloc]init];
        car.coordinate=carCoordinates[i];
        car.title=[NSString stringWithFormat:@"%d号保障车",i];
        car.subtitle=[NSString stringWithFormat:@"(%f,%f)",carCoordinates[i].latitude,carCoordinates[i].longitude];
        
        [self.carAnnotations addObject:car];
    }



}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;
        //设置标注可以拖动，默认为NO
        
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        
        
        if ([self.flyAnnotations containsObject:annotation]) {
            annotationView.pinColor=MAPinAnnotationColorRed;
            annotationView.tag=100+[self.flyAnnotations indexOfObject:annotation];
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"building"]];
        }else if ([self.carAnnotations containsObject:annotation]){
            annotationView.pinColor=MAPinAnnotationColorGreen;
            annotationView.tag=1000+[self.carAnnotations indexOfObject:annotation];
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"restaurant"]];
        }else{
            annotationView.pinColor=MAPinAnnotationColorPurple;
            annotationView.tag=1000000000;
        }
        return annotationView;
    }
    return nil;
}


- (void)createSpreadButtonSettings{
    _horizontal=NO;
    _titleArray=@[@"标准",@"卫星",@"夜景",@"导航"];
    _spreadButton = [[SpreadButton alloc]initWithTitleArray:_titleArray delegate:self];
    _spreadButton.frame = CGRectMake(40, 70, 60, 30);
    _spreadButton.titleArray = _titleArray;
    _spreadButton.directionType = HorizontalDirection;
    
    [_spreadButton setTitle:_titleArray[0] forState:UIControlStateNormal];
    _spreadButton.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_spreadButton];
    
}
- (void)spreadButton:(SpreadButton *)button clickButtonAtIndex:(int)index{
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    self.view.backgroundColor = colorArray[index];
    [button setTitle:_titleArray[index] forState:UIControlStateNormal];
    NSString *str=[NSString stringWithFormat:@"%@",_titleArray[index]];
    if ([str isEqualToString:@"标准"]) {
        [self.mapView setMapType:MAMapTypeStandard];
    }else if ([str isEqualToString:@"卫星"]){
        [self.mapView setMapType:MAMapTypeSatellite];
        
        
        
    }else if ([str isEqualToString:@"夜景"]){
        [self.mapView setMapType:MAMapTypeStandardNight];
    }else{
        [self.mapView setMapType:MAMapTypeStandard];
    }
    
    
    
}

/*!
 @brief 当mapView新添加annotation views时调用此接口
 @param mapView 地图View
 @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    NSLog(@"===========点击1");
}

/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param view 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"===========点击2");
}

/*!
 @brief 当取消选中一个annotation views时调用此接口
 @param mapView 地图View
 @param view 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"===========点击3");
}

/*!
 @brief 标注view的accessory view(必须继承自UIControl)被点击时调用此接口
 @param mapView 地图View
 @param view callout所属的标注view
 @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"===========点击4");
    NSInteger value=view.tag;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"详情" message:[NSString stringWithFormat:@"flightId:%ld 无接口 获取数据失败",(long)value] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
    
    
}

/**
 *  标注view的calloutview整体点击时调用此接口
 *
 *  @param mapView 地图的view
 *  @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view {
    NSLog(@"===========点击5");
}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
