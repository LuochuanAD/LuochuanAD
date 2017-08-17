//
//  TimeUpdateTask.h
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUpdateTask : NSObject
- (instancetype)initWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector;
- (void)shutDwon;
@end
