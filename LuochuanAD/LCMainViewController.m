//
//  LCMainViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LCMainViewController.h"
#import "LCSuspendCustomBaseViewController.h"
#import "LCTwitterAndFaceBookSharedViewController.h"
//touchID
#import <LocalAuthentication/LocalAuthentication.h>
#import <WatchConnectivity/WatchConnectivity.h>

#import "LCPassBookTypeViewController.h"

@interface LCMainViewController ()<WCSessionDelegate>

@end

@implementation LCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我的";
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"FaceBookOrTwitter" style:UIBarButtonItemStylePlain target:self action:@selector(sharedButtonClicked)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithTitle:@"PassBookAndPassKit" style:UIBarButtonItemStylePlain target:self action:@selector(pushToPassBook)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    
    LCSuspendCustomBaseViewController *floatVC=[[LCSuspendCustomBaseViewController alloc]init];
    floatVC.suspendType=BUTTON;
    [self addChildViewController:floatVC];
    [self.view addSubview:floatVC.view];
    [self receiveAndPushMessageToIWatch];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)receiveAndPushMessageToIWatch{
    if ([WCSession isSupported]) {
        WCSession *session=[WCSession defaultSession];
        session.delegate=self;
        [session activateSession];
    }
    
    NSURL *url=[NSURL URLWithString:@"http://app.shanghaiairport.com/airport_platform/rest/flight?operate=queryAirportSurveyV016&airport=PVG"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *imageUrlStr=[dic objectForKey:@"weatherIcon"];
    NSString *weathStr=[dic objectForKey:@"weatherDesc"];
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]];

    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:imageData,@"weathIcon",weathStr,@"weatherDesc", nil];
    WCSession *session=[WCSession defaultSession];
    [session sendMessage:dict replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"==iphone===%@",replyMessage);
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"===iphone===%@",error);
    }];
    
    
}
- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2){
    
}

- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE{
    
}

- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE{
    
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler{
    
}

//touchID 仅仅只支持5s以上
- (void)sharedButtonClicked{
    LAContext *myContext=[[LAContext alloc]init];
    NSError *error=nil;
    NSString *myReasonString=@"请求验证指纹";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myReasonString reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    LCTwitterAndFaceBookSharedViewController *sharedVC=[[LCTwitterAndFaceBookSharedViewController alloc]init];
                    [self.navigationController pushViewController:sharedVC animated:YES];
                });
                
            }else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"验证失败" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            
            }
        }];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"当前设备不支持touchID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

    
}

- (UIImage *)getNormalImage:(UIView *)view{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.frame=[UIScreen mainScreen].bounds;
    CGRect frame=window.frame;
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef contexRef=UIGraphicsGetCurrentContext();
    [view.layer renderInContext:contexRef];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)pushToPassBook{
    LCPassBookTypeViewController *passBookTypeVC=[[LCPassBookTypeViewController alloc]init];
    [self.navigationController pushViewController:passBookTypeVC animated:YES];

}
@end
