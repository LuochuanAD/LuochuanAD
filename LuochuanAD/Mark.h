//
//  Mark.h
//  LuochuanAD
//
//  Created by 罗川 on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkVisitor.h"
@protocol Mark <NSObject,NSCopying,NSCoding>

@property (nonatomic, strong) UIColor *color;//颜色
@property (nonatomic, assign) CGFloat size;//大小
@property (nonatomic, assign) CGPoint location;//位置
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;

- (id)copy;
- (void)addMark:(id <Mark>)mark;
- (void)removeMark:(id <Mark>)mark;
- (id <Mark>)childMarkAtIndex:(NSUInteger)index;

- (void)acceptMarkVisitor:(id <MarkVisitor>)visitor;
- (NSEnumerator *)enumerator;
- (void)enumerateMarkUsingBlock:(void(^)(id <Mark> item,BOOL *stop))block;
- (void)drawWithContext:(CGContextRef)context;

@end

