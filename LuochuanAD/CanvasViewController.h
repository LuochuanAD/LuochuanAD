//
//  CanvasViewController.h
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasView.h"
#import "Scribble.h"
#import "CanvasViewGenerator.h"
#import "CommandBarButton.h"
#import "NSMutableArray+Stack.h"
@interface CanvasViewController : UIViewController
{
    CGPoint _startPoint;
}
@property (nonatomic, strong) CanvasView *canvasView;
@property (nonatomic, retain) Scribble *scribble;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

- (void)loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator;

- (NSInvocation *)drawScribbleInvocation;
- (NSInvocation *)undrawScribbleinvocation;
- (void)executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation;
- (void)unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;

- (IBAction)onCustomBarButton:(CommandBarButton *)sender;
- (IBAction)onBarbutton:(UIBarButtonItem *)sender;


@end
