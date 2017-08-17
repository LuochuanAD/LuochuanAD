//
//  PaperCanvasView.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "PaperCanvasView.h"

@implementation PaperCanvasView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *backgroundImage=[UIImage imageNamed:@"paper"];
        UIImageView *backgroundView=[[UIImageView alloc]initWithImage:backgroundImage];
        [self addSubview:backgroundView];
    }
    return self;
}

@end
