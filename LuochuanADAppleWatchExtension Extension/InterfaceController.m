//
//  InterfaceController.m
//  LuochuanADAppleWatchExtension Extension
//
//  Created by care on 17/5/15.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
{
    NSData *weathIcon;
    NSString *weathStr;
}
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];


}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if ([WCSession isSupported]) {
        WCSession *session=[WCSession defaultSession];
        session.delegate=self;
        [session activateSession];
    }
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
    
}

- (IBAction)pushToGithubAddress {
    WCSession *session=[WCSession defaultSession];
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"github",@"push", nil];
    [session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"==watch===%@",replyMessage);
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"===watch===%@",error);
    }];

    
    
}
- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2){
    
}

- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE{
    
}

- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE{
    
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler{
    //NSString *name = [message objectForKey:@"Name"];
    weathIcon=[message objectForKey:@"weathIcon"];
    weathStr=[message objectForKey:@"weatherDesc"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weathStr.length>0) {
            self.weathIcon.image=[UIImage imageWithData:weathIcon];
            self.weathLable.text=weathStr;
        }
    });
}
@end



