//
//  SetStrokeColorCommand.m
//  LuochuanAD
//
//  Created by care on 2017/6/13.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "SetStrokeColorCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation SetStrokeColorCommand
- (void)execute{
    CGFloat redValue=0.0;
    CGFloat greenValue=0.0;
    CGFloat blueValue=0.0;
    [_delegate command:self didRequestColorComonetsForRed:&redValue withGreen:&greenValue withBlue:&blueValue];
    if (_rgbValuesProvider!=nil) {
        _rgbValuesProvider(&redValue,&greenValue,&blueValue);
    }
    UIColor *color=[UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
    CoordinatingController *coordinator=[CoordinatingController sharedinstance];
    CanvasViewController *controller=[coordinator canvasViewController];
    [controller setStrokeColor:color];
    
    [_delegate command:self didFinnishColorUpdateWithColor:color];
    if (_postColorUpdateProvider!=nil) {
        _postColorUpdateProvider(color);
    }
    

}



@end
