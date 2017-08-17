//
//  DelegateUpdateTask.m
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "DelegateUpdateTask.h"

@implementation DelegateUpdateTask
- (void)startUpdate{
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
   //执行网络调用,报告结果
    NSArray *records=@[@"罗川",@"25"];
    dispatch_async(dispatch_get_main_queue(), ^{
        id<UpdateTaskDelegate> delegate =self.delegate;
        if (!delegate) {
            return;
        }else{
            if ([delegate respondsToSelector:@selector(onDataAvailable:)]) {
                [delegate onDataAvailable:records];
            }
        }
    });
    
});

}
- (void)cancel{
    //取消执行中的网络请求
    self.delegate=nil;

}
@end
