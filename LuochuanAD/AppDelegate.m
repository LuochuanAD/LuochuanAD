//
//  AppDelegate.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchScreenViewController.h"
#import "LCMainViewController.h"
#import "LCTabBarViewController.h"
#import "LCForwardOneViewController.h"
#import "LCForwardTwoViewController.h"
#import "LCBackwardOneViewController.h"
#import "LCBackwardTwoViewController.h"
//#import "SGLNavigationViewController.h"
//#import "MLNavigationController.h"

@interface AppDelegate ()
{
    LCTabBarViewController *tabBarVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AMapServices sharedServices].apiKey=@"bd1a9bb8de2061db8e283827d76701ca";
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    tabBarVC=[[LCTabBarViewController alloc]init];
    
    LCForwardOneViewController *forwardOneVC=[[LCForwardOneViewController alloc]init];
    UINavigationController *forwardOneNav=[[UINavigationController alloc]initWithRootViewController:forwardOneVC];
    forwardOneNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"One" image:[[UIImage imageNamed:@"lcmain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"lcmain1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    LCForwardTwoViewController *forwardTwoVC=[[LCForwardTwoViewController alloc]init];
    UINavigationController *forwardTwoNav=[[UINavigationController alloc]initWithRootViewController:forwardTwoVC];
    forwardTwoNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Two" image:[[UIImage imageNamed:@"lcflight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"lcflight1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    LCMainViewController *mainVC=[[LCMainViewController alloc]init];
    UINavigationController *mainNav=[[UINavigationController alloc]initWithRootViewController:mainVC];
    LCBackwardOneViewController *backwardOneVC=[[LCBackwardOneViewController alloc]init];
    UINavigationController *backwardOneNav=[[UINavigationController alloc]initWithRootViewController:backwardOneVC];
    backwardOneNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"One" image:[[UIImage imageNamed:@"lcairport"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"lcairport1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    LCBackwardTwoViewController *backwardTwoVC=[[LCBackwardTwoViewController alloc]init];
    UINavigationController *backwardTwoNav=[[UINavigationController alloc]initWithRootViewController:backwardTwoVC];
    backwardTwoNav.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Two" image:[[UIImage imageNamed:@"lcmine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"lcmine1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    tabBarVC.viewControllers=@[forwardOneNav,forwardTwoNav,mainNav,backwardOneNav,backwardTwoNav];
    self.window.rootViewController=tabBarVC;
    self.window.backgroundColor=[UIColor whiteColor];
    tabBarVC.selectedIndex=2;//指定当前页
    [self.window makeKeyAndVisible];
    
    
    __block LaunchScreenViewController *lanchVC=[[LaunchScreenViewController alloc]init];
    [self.window addSubview:lanchVC.view];
    [lanchVC viewScrollDidEnd:^{
        [lanchVC.view removeFromSuperview];
        lanchVC=nil;
     [UIView animateWithDuration:0.1 animations:^{
         mainVC.view.transform=CGAffineTransformMakeScale(1.2, 1.2);
     } completion:^(BOOL finished) {
         mainVC.view.transform=CGAffineTransformMakeScale(1.0, 1.0);
     }];
    }];
    
    [self handleLocationManagerWithApplication:application launchOptions:launchOptions];
    
    if (![UIPrintInteractionController isPrintingAvailable]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"当前设备不支持打印机" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
        [alert show];
    }
    /**-------------首次启动-----------------*/
    NSString *deviceId=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"--------deviceId----------%@",deviceId);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    BOOL firstLaunch=![defaults objectForKey:@"appLaunched"];
    if (firstLaunch) {
        [defaults setBool:YES forKey:@"appLaunched"];
        [defaults synchronize];
        NSLog(@"----------安装应用后的首次启动------------");
    }else{
        NSLog(@"-----------第二次-----------------");
    }
    NSString *accessToken=nil;
    if (!firstLaunch) {
        accessToken=[defaults stringForKey:@"accessToken"];
    }
    if (accessToken) {
        //用户登录
        NSLog(@"---------用户登录----------");
    }else{
        if (firstLaunch) {
        //首次启动
            NSLog(@"------------首次启动--------------");
        }else{
        //用户未登录
            NSLog(@"--------------用户未登录--------------------");
        }
    
    }
    /**-------------首次启动-----------------*/
    
    
    
    
    
    
    return YES;
}

-(void) handleLocationManagerWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    self.sharedLocationManager = [LocationManager sharedInstance];
    self.sharedLocationManager.resume = NO;
    [self.sharedLocationManager saveApplicationStatusToPList:@"didFinishLaunchingWithOptions"];
    if ([application backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied || [application backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请在iPhone的“设置-通用-后台应用刷新”选项中，允许上海机场APP开启后台应用刷新！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }else{
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            self.sharedLocationManager.resume = YES;
            [self.sharedLocationManager startMonitoringLocation];
            [self.sharedLocationManager saveResumeLocationToPList];
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.sharedLocationManager restartMonitoringLocation];
    [self.sharedLocationManager saveApplicationStatusToPList:@"applicationDidEnterBackground"];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.sharedLocationManager saveApplicationStatusToPList:@"applicationDidBecomeActive"];
    self.sharedLocationManager.resume = NO;
    [self.sharedLocationManager startMonitoringLocation];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self.sharedLocationManager saveApplicationStatusToPList:@"applicationWillTerminate"];
}


@end
