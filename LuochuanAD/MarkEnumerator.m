//
//  MarkEnumerator.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "MarkEnumerator.h"

@implementation MarkEnumerator
- (NSArray *)allObjects{
    return [[_stack reverseObjectEnumerator] allObjects];
}
- (id)nextObject{
    return [_stack pop];

}
- (id)initWithMark:(id<Mark>)mark{
    if (self=[super init]) {
        _stack=[[NSMutableArray alloc]initWithCapacity:[mark count]];
        [self traverseAndBuildStackWithMark:mark];
    }
    return self;

}
- (void)traverseAndBuildStackWithMark:(id<Mark>)mark{
    if (mark==nil) {
        return;
    }
    [_stack push:mark];
    NSUInteger index=[mark count];
    id <Mark> childMark;
    while (childMark ==[mark childMarkAtIndex:--index]) {
        [self traverseAndBuildStackWithMark:childMark];
    }

}
@end
