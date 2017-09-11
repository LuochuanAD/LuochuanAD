//
//  HPUpdaterService.h
//  LuochuanAD
//
//  Created by care on 2017/9/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPUser.h"
@interface HPUpdaterService : NSObject
+ (HPUpdaterService *)sharedInstance;

//读写锁 (线程安全且高吞吐量)
- (id)objectForKey:(id<NSCopying>)key;
- (void)setObject:(id)object forKey:(id<NSCopying>)key;
- (id)removeObjectForKey:(id<NSCopying>)key;
- (void)clear;

//同步块
- (void)updateUser:(HPUser *)user properties:(NSDictionary *)properties;
@end
