//
//  RequestClient.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "RequestClient.h"

@implementation RequestClient
+ (RequestClient *)sharedSessionManager{
    static dispatch_once_t onceToken;
    static RequestClient *sessionManager;
    dispatch_once(&onceToken, ^{
        sessionManager=[RequestClient manager];
    });
    return sessionManager;
}
@end
