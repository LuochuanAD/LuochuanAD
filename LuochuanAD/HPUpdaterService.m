//
//  HPUpdaterService.m
//  LuochuanAD
//
//  Created by care on 2017/9/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "HPUpdaterService.h"
static const  char * const kCatchQueueName="com.luochuanad.luochuanad";


@interface HPUpdaterService()
@property (nonatomic, readonly) NSMutableDictionary *catchObjects;
@property (nonatomic, readonly) dispatch_queue_t queue;
@end

@implementation HPUpdaterService
+ (HPUpdaterService *)sharedInstance{
    static HPUpdaterService *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HPUpdaterService alloc]init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _catchObjects=[NSMutableDictionary dictionary];
        _queue=dispatch_queue_create(kCatchQueueName, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    }
    return self;
}
- (id)objectForKey:(id<NSCopying>)key{
    __block id rv=nil;
    dispatch_async(self.queue, ^{
        rv=[self.catchObjects objectForKey:key];
    });
    return rv;
}
- (void)setObject:(id)object forKey:(id<NSCopying>)key{
    dispatch_barrier_async(self.queue, ^{
        [self.catchObjects setObject:object forKey:key];
    });
}
- (id)removeObjectForKey:(id<NSCopying>)key{
    __block id rv=nil;
    dispatch_async(self.queue, ^{
        rv=[self.catchObjects objectForKey:key];
        [self.catchObjects removeObjectForKey:key];
    });
    return rv;
}
- (void)clear{
    dispatch_async(self.queue, ^{
        [self.catchObjects removeAllObjects];
    });
}



- (void)updateUser:(HPUser *)user properties:(NSDictionary *)properties{
    @synchronized (user) {
        NSString *fn=[properties objectForKey:@"firstName"];
        if (fn!=nil) {
            user.firstName=fn;
        }
        NSString *ln=[properties objectForKey:@"lastName"];
        if (ln!=nil) {
            user.lastName=ln;
        }
    }

}
@end
