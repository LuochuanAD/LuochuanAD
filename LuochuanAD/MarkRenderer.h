//
//  MarkRenderer.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarkVisitor.h"
#import "Dot.h"
#import "Vertex.h"
#import "Stroke.h"
@interface MarkRenderer : NSObject<MarkVisitor>
{
    @private
    BOOL _shouldMoveContexToDot;
    @protected
    CGContextRef _context;
    
}
- (id)initWithCGContext:(CGContextRef)context;
- (void)visitMark:(id<Mark>)mark;
- (void)visitDot:(Dot *)dot;
- (void)visitVertex:(Vertex *)vertex;
- (void)visitStroke:(Stroke *)stroke;
@end
