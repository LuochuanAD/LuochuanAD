//
//  CanvasViewController.m
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "CanvasViewController.h"
#import "Dot.h"
#import "Stroke.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController
- (void)setScribble:(Scribble *)scribble{
    if (_scribble!=scribble) {
        _scribble=scribble;
        [_scribble addObserver:self forKeyPath:@"mark" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    CanvasViewGenerator *defaultGenerator=[[CanvasViewGenerator alloc]init];
    [self loadCanvasViewWithGenerator:defaultGenerator];
    Scribble *scribble=[[Scribble alloc]init];
    [self setScribble:scribble];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    CGFloat redValue=[ud floatForKey:@"red"];
    CGFloat greenValue=[ud floatForKey:@"green"];
    CGFloat blueValue=[ud floatForKey:@"blue"];
    CGFloat sizeValue=[ud floatForKey:@"size"];
    [self setStrokeSize:sizeValue];
    [self setStrokeColor:[UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0]];
 
}
- (void)setStrokeSize:(CGFloat)strokeSize{
    if (strokeSize<5.0) {
        _strokeSize=5.0;
    }else{
        _strokeSize=strokeSize;
    }

}

- (IBAction)onBarbutton:(UIBarButtonItem *)sender {
    if (sender.tag==4) {
        [self.undoManager undo];
        
    }else if (sender.tag==5){
        [self.undoManager redo];
    
    }
    
    
}
- (IBAction)onCustomBarButton:(CommandBarButton *)sender {
    [[sender lcCommand] execute];
}
- (void)loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator{
    [_canvasView removeFromSuperview];
    CGRect aFrame=CGRectMake(0, 0, WINDOWS.width, WINDOWS.height-44);
    CanvasView *aCanvas=[generator canvasViewWithFram:aFrame];
    [self setCanvasView:aCanvas];
    
    NSInteger viewIndex=[[[self view] subviews] count]-1;
    [[self view] insertSubview:_canvasView atIndex:viewIndex];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _startPoint= [[touches anyObject] locationInView:_canvasView];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint lastPoint=[[touches anyObject]previousLocationInView:_canvasView];
    if (CGPointEqualToPoint(lastPoint, _startPoint)) {
        id<Mark>newStroke=[[Stroke alloc]init];
        [newStroke setColor:_strokeColor];
        [newStroke setSize:_strokeSize];
        
        NSInvocation *drawInvocation=[self drawScribbleInvocation];
        [drawInvocation setArgument:&newStroke atIndex:2];
        
        NSInvocation *undrawInvocation=[self undrawScribbleinvocation];
        [undrawInvocation setArgument:&newStroke atIndex:2];
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    CGPoint thisPoint=[[touches anyObject] locationInView:_canvasView];
    Vertex *vertex=[[Vertex alloc]initWithlocation:thisPoint];
    [_scribble addMark:vertex shouldAddToPreviousMark:YES];

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint lastPoint=[[touches anyObject] previousLocationInView:_canvasView];
    CGPoint thisPoint=[[touches anyObject] locationInView:_canvasView];
    if (CGPointEqualToPoint(lastPoint, thisPoint)) {
        Dot *singleDot=[[Dot alloc]initWithlocation:thisPoint];
        [singleDot setColor:_strokeColor];
        [singleDot setSize:_strokeSize];
        
        NSInvocation *drawInvacation=[self drawScribbleInvocation];
        [drawInvacation setArgument:&singleDot atIndex:2];
        NSInvocation *undrawInvocation=[self undrawScribbleinvocation];
        [undrawInvocation setArgument:&singleDot atIndex:2];
        [self executeInvocation:drawInvacation withUndoInvocation:undrawInvocation];
        
        
    }
    _startPoint=CGPointZero;

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _startPoint=CGPointZero;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isKindOfClass:[Scribble class]]&&[keyPath isEqualToString:@"mark"]) {
        id<Mark>mark=[change objectForKey:NSKeyValueChangeNewKey];
        [_canvasView setMark:mark];
        [_canvasView setNeedsDisplay];
    }


}
- (NSInvocation *)drawScribbleInvocation{
    NSMethodSignature *executeMethodSignature=[_scribble methodSignatureForSelector:@selector(addMark:shouldAddToPreviousMark:)];

    NSInvocation *drawInvocation=[NSInvocation invocationWithMethodSignature:executeMethodSignature];
    [drawInvocation setTarget:_scribble];
    [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
    BOOL attachTopreviousMark= NO;
    [drawInvocation setArgument:&attachTopreviousMark atIndex:3];
    return drawInvocation;
}
- (NSInvocation *)undrawScribbleinvocation{
    NSMethodSignature *unexecuteMethodSinature=[_scribble methodSignatureForSelector:@selector(removeMark:)];
    NSInvocation *undrawInvocation=[NSInvocation invocationWithMethodSignature:unexecuteMethodSinature];
    [undrawInvocation setTarget:_scribble];
    [undrawInvocation setSelector:@selector(removeMark:)];
    return undrawInvocation;


}
- (void)executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation{
    [invocation retainArguments];
    [[self.undoManager prepareWithInvocationTarget:self] unexecuteInvocation:undoInvocation withRedoInvocation:invocation];
    [invocation invoke];
    

}
- (void)unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation{
    [[self.undoManager prepareWithInvocationTarget:self] executeInvocation:redoInvocation withUndoInvocation:invocation];
    [invocation invoke];
}
@end
