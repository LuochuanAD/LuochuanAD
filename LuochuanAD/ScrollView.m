//
//  ScrollView.m
//  lcTestCADemo
//
//  Created by care on 2018/2/5.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

+ (Class)layerClass{
    return [CAScrollLayer class];
}
- (void)setUp{
    self.layer.masksToBounds=YES;
    UIPanGestureRecognizer *recognizer=nil;
    recognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
    NSLog(@"-------------------------");
    
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
    [self setUp];
    
}
- (void)pan:(UIPanGestureRecognizer *)recoginizer{
    CGPoint offect=self.bounds.origin;
    offect.x -=[recoginizer translationInView:self].x;
    offect.y -=[recoginizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollToPoint:offect];
    [recoginizer setTranslation:CGPointZero inView:self];
  
    
}

@end
