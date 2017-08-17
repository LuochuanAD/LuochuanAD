//
//  RequestClient.h
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface RequestClient : AFHTTPSessionManager
+ (RequestClient *)sharedSessionManager;
@end
