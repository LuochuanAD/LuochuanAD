//
//  DeleteScribbleCommand.m
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "DeleteScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation DeleteScribbleCommand
- (void)execute{
    CoordinatingController *coordinatingController=[CoordinatingController sharedinstance];
    CanvasViewController *canvasVC=coordinatingController.canvasViewController;
    Scribble *newScrbble=[[Scribble alloc]init];
    [canvasVC setScribble:newScrbble];

}
@end
