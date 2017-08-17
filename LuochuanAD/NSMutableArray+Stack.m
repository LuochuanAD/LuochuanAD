//
//  NSMutableArray+Stack.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)
- (void)push:(id)object{
    if (object !=nil) {
        [self addObject:object];
    }

}
- (id)pop{
    if ([self count]==0) {
        return nil;
    }
    id object=[self lastObject];
    [self removeLastObject];
    return object;

}
- (void)dropBottom{
    if ([self count]==0) {
        return;
    }
    [self removeObjectAtIndex:0];
}
@end
