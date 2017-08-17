//
//  MarkVisitor.h
//  LuochuanAD
//
//  Created by 罗川 on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Mark;
@class Dot,Vertex,Stroke;
@protocol MarkVisitor <NSObject>
- (void)visitMark:(id <Mark>)mark;
- (void)visitDot:(Dot *)dot;
- (void)visitVertex:(Vertex *)vertex;
- (void)visitStroke:(Stroke *)stroke;

@end

