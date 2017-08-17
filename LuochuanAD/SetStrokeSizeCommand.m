//
//  SetStrokeSizeCommand.m
//  LuochuanAD
//
//  Created by care on 2017/6/13.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "SetStrokeSizeCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation SetStrokeSizeCommand
- (void)execute{
    CGFloat strokeSize=1;
    [_delegate command:self didRequestForStrokeSize:&strokeSize];
    CoordinatingController *coordinator=[CoordinatingController sharedinstance];
    CanvasViewController *controller=[coordinator canvasViewController];
    [controller setStrokeSize:strokeSize];
}
@end
