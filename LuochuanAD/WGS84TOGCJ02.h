//
//  WGS84TOGCJ02.h
//  LuochuanAD
//
//  Created by care on 17/4/19.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface WGS84TOGCJ02 : NSObject
// 判断是否已经超出中国范围
+ (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;

// 将WGS-84转为GCJ-02(火星坐标)
// 转GCJ-02
+ (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end
