//
//  DelegateUpdateTask.h
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdateTaskDelegate <NSObject>

- (void)onDataAvailable:(NSArray *)records;

@end

@interface DelegateUpdateTask : NSObject
@property (nonatomic, weak) id <UpdateTaskDelegate> delegate;
- (void)startUpdate;
- (void)cancel;
@end
