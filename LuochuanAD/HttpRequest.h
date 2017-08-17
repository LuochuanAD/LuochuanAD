//
//  HttpRequest.h
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    GETRequest,
    POSTRequest=1
}RequestType;

@class HttpRequest;
@protocol HTTPRequestDelegate <NSObject>
@optional
- (void)requestStarted:(HttpRequest *)request;
- (void)request:(HttpRequest *)request didReciveData:(id)data;
- (void)requestFailed:(HttpRequest *)request;
@end

@interface HttpRequest : NSObject
@property (nonatomic, weak)NSObject<HTTPRequestDelegate> *delegate;
+ (instancetype)sharedHttpRequest;
- (void)startRequestType:(RequestType)requestType withParms:(NSDictionary *)parms withPath:(NSString *)path;
@end
