//
//  LCFreeDragView.m
//  LuochuanAD
//
//  Created by care on 17/5/4.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCFreeDragView.h"

@interface LCFreeDragView()
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint startFramePoint;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation LCFreeDragView


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
        _imageView.userInteractionEnabled=YES;
        _imageView.clipsToBounds=YES;
        _imageView.frame=(CGRect){CGPointZero,self.bounds.size};
        [self.contentViewForDrag addSubview:_imageView];
    }
    return _imageView;
}
- (UIButton *)button{
    if (!_button) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.clipsToBounds=YES;
        _button.userInteractionEnabled=YES;
        _button.frame=(CGRect){CGPointZero,self.bounds.size};
    }
    return _button;
}
- (UIView *)contentViewForDrag{
    if (!_contentViewForDrag) {
        _contentViewForDrag=[[UIView alloc]init];
        _contentViewForDrag.clipsToBounds=YES;
        _contentViewForDrag.frame=(CGRect){CGPointZero,self.bounds.size};
        [self addSubview:self.contentViewForDrag];
    }
    return _contentViewForDrag;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];

}
- (void)layoutSubviews{
    if (self.freeRect.origin.x!=0||self.freeRect.origin.y!=0||self.freeRect.size.height!=0||self.freeRect.size.width!=0) {
        
    }else{
        self.freeRect=(CGRect){CGPointZero,self.superview.bounds.size};
    }

}
- (void)setUp{
    self.dragEnable=YES;
    self.clipsToBounds=YES;
    self.isKeepBounds=NO;
    self.backgroundColor=[UIColor lightGrayColor];
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDragView)];
    [self addGestureRecognizer:singleTap];
    _panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragAction:)];
    _panGestureRecognizer.minimumNumberOfTouches=1;
    _panGestureRecognizer.maximumNumberOfTouches=1;
    [self addGestureRecognizer:_panGestureRecognizer];

}
- (void)dragAction:(UIPanGestureRecognizer *)pan{
    if (self.dragEnable==NO) {
        return;
    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            if (self.beginDragBlock) {
                self.beginDragBlock(self);
            }
            [pan setTranslation:CGPointMake(0, 0) inView:self];
            self.startPoint=[pan translationInView:self];
            [[self superview] bringSubviewToFront:self];
            break;
        case UIGestureRecognizerStateChanged:
            if (self.DuringDragBlock) {
                self.DuringDragBlock(self);
            }
            CGPoint point=[pan translationInView:self];
            float dx;
            float dy;
            switch (self.draDirection) {
                case DragDirectionAny:
                    dx=point.x-self.startPoint.x;
                    dy=point.y-self.startPoint.y;
                    break;
                case DragDirectionHorizontal:
                    dx=point.x-self.startPoint.x;
                    dy=0;
                    break;
                case DragDirectionVertical:
                    dx=0;
                    dy=point.y-self.startPoint.y;
                    break;
                default:
                    dx=point.x-self.startPoint.x;
                    dy=point.y-self.startPoint.y;
                    break;
            }
            CGPoint newCenter=CGPointMake(self.center.x+dx, self.center.y+dy);
            self.center=newCenter;
            [pan setTranslation:CGPointMake(0, 0) inView:self];
            
            break;
        case UIGestureRecognizerStateEnded:
            [self keepBounds];
            if (self.EndDragBlock) {
                self.EndDragBlock(self);
            }
            break;
            
        default:
            break;
    }

}
- (void)clickDragView{
    if (self.ClickDragViewBlock) {
        self.ClickDragViewBlock(self);
    }

}
- (void)keepBounds{
    float centerX=self.freeRect.origin.x+(self.freeRect.size.width-self.frame.size.width)/2;
    CGRect rect=self.frame;
    if (self.isKeepBounds==NO) {
        if (self.frame.origin.x<self.freeRect.origin.x) {
            CGContextRef context=UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"leftMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            rect.origin.x=self.freeRect.origin.x;
            [self setFrame:rect];
            [UIView commitAnimations];
        }else if (self.freeRect.origin.x+self.freeRect.size.width<self.frame.origin.x+self.frame.size.width){
            CGContextRef context=UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"rightMov" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            rect.origin.x=self.freeRect.origin.x+self.freeRect.size.width-self.frame.size.width;
            [self setFrame:rect];
            [UIView commitAnimations];
        }
            
    }else if (self.isKeepBounds==YES){
        if (self.frame.origin.x<centerX) {
            CGContextRef context=UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"leftMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            rect.origin.x=self.freeRect.origin.x;
            [self setFrame:rect];
            [UIView commitAnimations];
        }else{
            CGContextRef context=UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"rightMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5];
            rect.origin.x=self.freeRect.origin.x+self.freeRect.size.width-self.frame.size.width;
            [self setFrame:rect];
            [UIView commitAnimations];
        }
    
    
    }
    if (self.frame.origin.y<self.freeRect.origin.y) {
        CGContextRef context=UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"topMov" context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        rect.origin.y=self.freeRect.origin.y;
        [self setFrame:rect];
        [UIView commitAnimations];
    }else if (self.freeRect.origin.y+self.freeRect.size.height<self.frame.size.height+self.frame.origin.y){
        CGContextRef context=UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"bottommove" context:context];
        [UIView setAnimationDuration:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        rect.origin.y=self.freeRect.origin.y+self.freeRect.size.height-self.frame.size.height;
        [self setFrame:rect];
        [UIView commitAnimations];
    
    }

}
@end
