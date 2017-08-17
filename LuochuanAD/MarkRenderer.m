//
//  MarkRenderer.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "MarkRenderer.h"

@implementation MarkRenderer
- (id)initWithCGContext:(CGContextRef)context{
    if(self=[super init]){
        _context=context;
        _shouldMoveContexToDot=YES;
    }
    return self;
}
- (void)visitMark:(id<Mark>)mark{
   
}
- (void)visitDot:(Dot *)dot{
    CGFloat x=[dot location].x;
    CGFloat y=[dot location].y;
    CGFloat frameSize=[dot size];
    CGRect frame=CGRectMake(x-frameSize/2.0, y-frameSize/2.0, frameSize, frameSize);
    CGContextSetFillColorWithColor(_context, [[dot color] CGColor]);
    CGContextFillEllipseInRect(_context, frame);
    
    

}
- (void)visitVertex:(Vertex *)vertex{
    CGFloat x=[vertex location].x;
    CGFloat y=[vertex location].y;
    if (_shouldMoveContexToDot) {
        CGContextMoveToPoint(_context, x, y);
        _shouldMoveContexToDot=NO;
    }else{
        CGContextAddLineToPoint(_context, x, y);
    
    }

}
- (void)visitStroke:(Stroke *)stroke{
    CGContextSetStrokeColorWithColor(_context, [[stroke color] CGColor]);
    CGContextSetLineWidth(_context, [stroke size]);
    CGContextSetLineCap(_context, kCGLineCapRound);
    CGContextStrokePath(_context);
    _shouldMoveContexToDot=YES;
}
@end
