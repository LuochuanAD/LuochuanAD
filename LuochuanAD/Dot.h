//
//  Dot.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Vertex.h"

@protocol MarkVisitor;
@interface Dot : Vertex

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor;
- (id)copyWithZone:(NSZone *)zone;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;



@end
