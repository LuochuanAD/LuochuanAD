//
//  TodayViewController.m
//  LuochuanADTodayExtension
//
//  Created by care on 17/5/12.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.extensionContext.widgetLargestAvailableDisplayMode=NCWidgetDisplayModeExpanded;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    [self reciveWeathMessige];
    completionHandler(NCUpdateResultNewData);
}
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    if (activeDisplayMode==NCWidgetDisplayModeCompact) {
        self.preferredContentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    }else{
        self.preferredContentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 183);
    }

}
- (void)reciveWeathMessige{
    NSURL *url=[NSURL URLWithString:@"http://app.shanghaiairport.com/airport_platform/rest/flight?operate=queryAirportSurveyV016&airport=PVG"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *imageUrlStr=[dic objectForKey:@"weatherIcon"];
    NSString *weathStr=[dic objectForKey:@"weatherDesc"];
    self.weathImgV.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]]];
    self.wethLable.text=weathStr;
    
    

}
@end
