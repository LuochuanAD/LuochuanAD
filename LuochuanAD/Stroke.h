//
//  Stroke.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "MarkEnumerator.h"

@protocol MarkVisitor;

@interface Stroke : NSObject<Mark>
{
    NSMutableArray *_children;

}
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id<Mark> lastChild;

- (void)addMark:(id<Mark>)mark;
- (void)removeMark:(id<Mark>)mark;
- (id<Mark>)childMarkAtIndex:(NSUInteger)index;
- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor;
- (id)copyWithZone:(NSZone *)zone;
- (NSEnumerator *)enumerator;
- (void)enumerateMarkUsingBlock:(void (^)(id<Mark>, BOOL *))block;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
