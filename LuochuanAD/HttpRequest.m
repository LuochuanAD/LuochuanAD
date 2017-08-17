//
//  HttpRequest.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "HttpRequest.h"
#import "RequestClient.h"
@interface HttpRequest()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation HttpRequest

+ (instancetype)sharedHttpRequest{
    static dispatch_once_t onceToken;
    static HttpRequest *httpRequest;
    dispatch_once(&onceToken, ^{
        httpRequest=[[HttpRequest alloc]init];
    });
    return httpRequest;
}

- (void)startRequestType:(RequestType)requestType withParms:(NSDictionary *)parms withPath:(NSString *)path{
    _manager=[RequestClient sharedSessionManager];
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    _manager.requestSerializer.timeoutInterval=12.0f;
    [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    if (requestType==GETRequest) {
        [_manager GET:path parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dataSource=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if ([_delegate respondsToSelector:@selector(request: didReciveData:)]) {
                [_delegate request:self didReciveData:dataSource];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
                [_delegate requestFailed:self];
            }
        }];
    }else if (requestType==POSTRequest){
    [_manager POST:path parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dataSource=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([_delegate respondsToSelector:@selector(request: didReciveData:)]) {
            [_delegate request:self didReciveData:dataSource];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:self];
        }
    }];
    }else{}
    if ([_delegate respondsToSelector:@selector(requestStarted:)]) {
        [_delegate requestStarted:self];
    }
}
@end
