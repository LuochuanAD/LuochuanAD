//
//  TimeUpdateTask.m
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "TimeUpdateTask.h"
#import "timeSourceModel.h"
@interface TimeUpdateTask()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TimeUpdateTask

- (instancetype)initWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector{
    if (self==[super init]) {
        self.target=target;
        self.selector=selector;
        self.timer=[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(fetchAndUpdate:) userInfo:nil repeats:YES];
    }
    return self;
}
- (void)fetchAndUpdate:(NSTimer *)timer{
    timeSourceModel *sources=[[timeSourceModel alloc]init];
    sources.name=@"罗川";
    sources.age=@"25";
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) sself=weakSelf;
        if (!sself||sself.target==nil) {
            return;
        }
        id target= sself.target;
        SEL selector= sself.selector;
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector withObject:sources];
        }
    });
    
}

- (void)shutDwon{
    [self.timer invalidate];
    self.timer=nil;
}
@end
