//
//  ViewController.m
//  LCTestAnimationDemo
//
//  Created by care on 2018/2/6.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "LCLayerViewController.h"
#define WINDOWS [UIScreen mainScreen].bounds.size
@interface LCLayerViewController ()<CAAnimationDelegate>
{
    UIImageView *hourImgV;
    UIImageView *minutImgV;
    UIImageView *secondImgV;
    NSTimer *timer;
}
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LCLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //闹钟
    /*
     UIImageView *clockImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
     clockImgV.frame=CGRectMake((WINDOWS.width-250)/2, 88, 250, 250);
     [self.view addSubview:clockImgV];
     
     hourImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hour"]];
     hourImgV.frame=clockImgV.frame;
     [self.view addSubview:hourImgV];
     minutImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minut"]];
     minutImgV.frame=clockImgV.frame;
     [self.view addSubview:minutImgV];
     secondImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"second"]];
     secondImgV.frame=clockImgV.frame;
     [self.view addSubview:secondImgV];
     
     timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     [self updateHandsAnimated:NO];
     */
    
    
    
    
    //宇宙飞船
    /*
     UIBezierPath *bezierPath=[[UIBezierPath alloc]init];
     [bezierPath moveToPoint:CGPointMake(0, 550)];
     [bezierPath addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(75, 400) controlPoint2:CGPointMake(225, 700)];
     
     CAShapeLayer *pathlayer=[CAShapeLayer layer];
     pathlayer.path=bezierPath.CGPath;
     pathlayer.fillColor=[UIColor clearColor].CGColor;
     pathlayer.strokeColor=[UIColor redColor].CGColor;
     pathlayer.lineWidth=3.0f;
     [self.view.layer addSublayer:pathlayer];
     
     CALayer *shipLayer=[CALayer layer];
     shipLayer.frame=CGRectMake(0, 0, 64, 64);
     shipLayer.position=CGPointMake(0, 550);
     shipLayer.contents=(__bridge id)[UIImage imageNamed:@"ship"].CGImage;
     [self.view.layer addSublayer:shipLayer];
     
     CAKeyframeAnimation *keyAnimation=[CAKeyframeAnimation animation];
     keyAnimation.keyPath=@"position";
     keyAnimation.duration=4.0;
     keyAnimation.path=bezierPath.CGPath;
     keyAnimation.rotationMode=kCAAnimationRotateAuto;//使飞船的头沿着曲线的方向
     keyAnimation.repeatCount=99;
     [shipLayer addAnimation:keyAnimation forKey:nil];
     */
    
    
    //虚拟属性
    
//    CALayer *shipLayer=[CALayer layer];
//    shipLayer.frame=CGRectMake(0, 0, 128, 128);
//    shipLayer.position=CGPointMake(150, 150);
//    shipLayer.contents=(__bridge id)[UIImage imageNamed:@"ship"].CGImage;
//    [self.view.layer addSublayer:shipLayer];
//
//    CABasicAnimation *animation=[CABasicAnimation animation];
//    animation.keyPath=@"transform.rotation";
//    animation.duration=2.0;
//    animation.byValue=@(M_PI*2);
//    [shipLayer addAnimation:animation forKey:nil];
    
    
    //组合动画
    /*
     UIBezierPath *bezierPath=[[UIBezierPath alloc]init];
     [bezierPath moveToPoint:CGPointMake(0, 550)];
     [bezierPath addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(75, 400) controlPoint2:CGPointMake(225, 700)];
     
     CAShapeLayer *pathlayer=[CAShapeLayer layer];
     pathlayer.path=bezierPath.CGPath;
     pathlayer.fillColor=[UIColor clearColor].CGColor;
     pathlayer.strokeColor=[UIColor redColor].CGColor;
     pathlayer.lineWidth=3.0f;
     [self.view.layer addSublayer:pathlayer];
     
     CALayer *colorlayer=[CALayer layer];
     colorlayer.frame=CGRectMake(0, 0, 64, 64);
     colorlayer.position=CGPointMake(0, 550);
     colorlayer.backgroundColor=[UIColor greenColor].CGColor;
     [self.view.layer addSublayer:colorlayer];
     
     
     //    CALayer *shipLayer=[CALayer layer];
     //    shipLayer.frame=CGRectMake(0, 0, 64, 64);
     //    shipLayer.position=CGPointMake(0, 550);
     //    shipLayer.contents=(__bridge id)[UIImage imageNamed:@"ship"].CGImage;
     //    [self.view.layer addSublayer:shipLayer];
     
     CAKeyframeAnimation *keyAnimation=[CAKeyframeAnimation animation];
     keyAnimation.keyPath=@"position";
     keyAnimation.path=bezierPath.CGPath;
     keyAnimation.rotationMode=kCAAnimationRotateAuto;//使飞船的头沿着曲线的方向
     
     
     CABasicAnimation *basicAnimation=[CABasicAnimation animation];
     basicAnimation.keyPath=@"backgroundColor";
     basicAnimation.toValue=(__bridge id)[UIColor redColor].CGColor;
     
     CAAnimationGroup *groupAnimation=[CAAnimationGroup animation];
     groupAnimation.animations=@[keyAnimation,basicAnimation];
     groupAnimation.duration=4.0;
     groupAnimation.repeatCount=99;
     [colorlayer addAnimation:groupAnimation forKey:nil];
     */
    
    
    
    //过渡
    self.imageView=[[UIImageView alloc]init];
    self.imageView.frame=CGRectMake(0, 64, 100, 100);
    [self.view addSubview:self.imageView];
    
    self.images=@[[UIImage imageNamed:@"ship"],[UIImage imageNamed:@"clock"],[UIImage imageNamed:@"hour"],[UIImage imageNamed:@"second"]];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 200, 100, 44);
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(buttonClickedForSwitchImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    
    
}
- (void)buttonClickedForSwitchImage{
    CATransition *transition=[CATransition animation];
    transition.type=kCATransitionMoveIn;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    UIImage *currentImage=self.imageView.image;
    NSUInteger index=(NSUInteger)[self.images indexOfObject:currentImage];
    index=(index+1)%[self.images count];
    self.imageView.image=self.images[index];
    
}


- (void)tick{
    [self updateHandsAnimated:YES];
}
- (void)updateHandsAnimated:(BOOL)animated{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components=[calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
    //闹钟
    CGFloat hourAngle=(components.hour/12.0)*M_PI*2.0;
    CGFloat minsAngle=(components.minute/60.0)*M_PI*2.0;
    CGFloat secondAngle=(components.second/60.0)*M_PI*2.0;
    
    [self setAngle:hourAngle forHand:hourImgV animated:animated];
    [self setAngle:minsAngle forHand:minutImgV animated:animated];
    [self setAngle:secondAngle forHand:secondImgV animated:animated];
    
//    hourImgV.transform=CGAffineTransformMakeRotation(hourAngle);
//    minutImgV.transform=CGAffineTransformMakeRotation(minsAngle);
//    secondImgV.transform=CGAffineTransformMakeRotation(secondAngle);
    
}
- (void)setAngle:(CGFloat )angle forHand:(UIView *)handView animated:(BOOL)animated{
    CATransform3D transform=CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        CABasicAnimation *animation=[CABasicAnimation animation];
        [self updateHandsAnimated:NO];
        animation.keyPath=@"transform";
        animation.toValue=[NSValue valueWithCATransform3D:transform];
        animation.duration=0.5;
        animation.delegate=self;
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
        
    }else{
        handView.layer.transform=transform;
    }
    
    
}
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    UIView *handView=[anim valueForKey:@"handView"];
    handView.layer.transform=[anim.toValue CATransform3DValue];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
