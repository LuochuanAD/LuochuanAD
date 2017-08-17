//
//  InterfaceController.h
//  LuochuanADAppleWatchExtension Extension
//
//  Created by care on 17/5/15.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
@interface InterfaceController : WKInterfaceController<WCSessionDelegate>
- (IBAction)pushToGithubAddress;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *weathIcon;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *weathLable;

@end
