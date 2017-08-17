//
//  Vertex.h
//  LuochuanAD
//
//  Created by 罗川 on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

@protocol MarkVisitor;
@interface Vertex : NSObject<Mark>
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id<Mark> lastChild;

- (id)initWithlocation:(CGPoint) location;
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
