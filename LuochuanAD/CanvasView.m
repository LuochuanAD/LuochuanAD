//
//  CanvasView.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "CanvasView.h"
#import "MarkRenderer.h"
@implementation CanvasView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    MarkRenderer *markRenderer=[[MarkRenderer alloc]initWithCGContext:context];
    [_mark acceptMarkVisitor:markRenderer];

}

@end
