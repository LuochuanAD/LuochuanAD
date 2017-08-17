//
//  OpenScribbleCommand.m
//  LuochuanAD
//
//  Created by care on 2017/6/12.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "OpenScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation OpenScribbleCommand
- (id)initWithScribbleSource:(id<ScribbleSources>)aScribbleSource{
    if (self=[super init]) {
        [self setScribbleSource:aScribbleSource];
    }
    return self;
}
- (void)execute{
    Scribble *scribble=[_scribbleSource scribble];
    CoordinatingController *coordinator=[CoordinatingController sharedinstance];
    CanvasViewController * controller=[coordinator canvasViewController];
    [controller setScribble:scribble];
    [coordinator viewChangeByObject:self];
}
@end
