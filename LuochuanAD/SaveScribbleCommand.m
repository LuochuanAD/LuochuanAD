//
//  SaveScribbleCommand.m
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "SaveScribbleCommand.h"
#import "CoordinatingController.h"
#import "UIView+UIImage.h"
#import "ScribbleManager.h"
@implementation SaveScribbleCommand
- (void)execute{
    CoordinatingController *coordinatingVC=[CoordinatingController sharedinstance];
    CanvasViewController *canvasVC=coordinatingVC.canvasViewController;
    UIImage *canvasViewImage=[[canvasVC canvasView] image];
    Scribble *scribble=[canvasVC scribble];
    ScribbleManager *scribbleManager=[[ScribbleManager alloc]init];
    [scribbleManager saveScribble:scribble thumbnail:canvasViewImage];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Your scribble has saved" message:NSBundleResourceRequestLowDiskSpaceNotification delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
