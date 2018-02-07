//
//  LCTestAlertViewController.m
//  LuochuanAD
//
//  Created by care on 2018/1/23.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "LCTestAlertViewController.h"
#import "Test3DViewController.h"
#import <CoreText/CoreText.h>
#import "LayerLable.h"
#import "ReflectionView.h"
#import "ScrollView.h"
@interface LCTestAlertViewController ()<CALayerDelegate>
{
    UIImageView *hourImgV;
    UIImageView *minutImgV;
    UIImageView *secondImgV;
    
    CALayer *blueLayer;
    
    
}
@property (nonatomic, strong) CALayer *colorlayer;
@property (nonatomic, strong) UIView *layerView;
@end

@implementation LCTestAlertViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    Test3DViewController *vc=[[Test3DViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    self.layerView=[[UIView alloc]init];
    self.layerView.frame=CGRectMake(0, 64, 200, 200);
    
    self.layerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.layerView];
    blueLayer=[CALayer layer];
    blueLayer.frame=CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor=[UIColor blueColor].CGColor;
    
    blueLayer.delegate=self;
    blueLayer.contentsScale=[UIScreen mainScreen].scale;
    
    [self.layerView.layer addSublayer:blueLayer];
    [blueLayer display];
    
    
    /*
     * clock
     */
    /**
    
    UIImageView *clockImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
    clockImgV.frame=CGRectMake(0, 270, 250, 250);
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
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [self tick];
    */
    
    /**
    
    UIView *test1View=[[UIView alloc]init];
    test1View.frame=CGRectMake(0, 200, 200, 200);
    [self.view addSubview:test1View];
    
    UIView *test2View=[[UIView alloc]init];
    test2View.frame=CGRectMake(250, 200, 200, 200);
    [self.view addSubview:test2View];
    
    UIView *test3View=[[UIView alloc]init];
    test3View.frame=CGRectMake(30, 400, 200, 200);
    [self.view addSubview:test3View];
    
    UIView *test4View=[[UIView alloc]init];
    test4View.frame=CGRectMake(250, 402, 200, 200);
    [self.view addSubview:test4View];
    
    
    UIImage *backgroundImage=[UIImage imageNamed:@"Sprites.png"];
//    [self addImage:backgroundImage withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:test1View.layer];
//    [self addImage:backgroundImage withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:test2View.layer];
//    [self addImage:backgroundImage withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:test3View.layer];
//    [self addImage:backgroundImage withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:test4View.layer];
    
    
    [self addImage:backgroundImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:test1View.layer];
    [self addImage:backgroundImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:test2View.layer];
    
    */
    
    
    /** 阴影
     UIView *layerView1=[[UIView alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
     layerView1.backgroundColor=[UIColor whiteColor];
     [self.view addSubview:layerView1];
     
     UIView *layerView2=[[UIView alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
     layerView2.backgroundColor=[UIColor clearColor];
     [self.view addSubview:layerView2];
     
     layerView1.layer.cornerRadius=20.0f;
     layerView1.layer.borderWidth=5.0f;
     
     layerView1.layer.shadowOpacity=0.5f;
     layerView1.layer.shadowOffset=CGSizeMake(0, 5.0f);
     layerView1.layer.shadowRadius=5.0f;
     
     layerView2.layer.shadowOpacity=0.5f;
     
     CGMutablePathRef squarePath=CGPathCreateMutable();
     CGPathAddRect(squarePath, NULL, layerView1.bounds);
     layerView1.layer.shadowPath=squarePath;
     CGPathRelease(squarePath);
     
     
     CGMutablePathRef circlePath=CGPathCreateMutable();
     CGPathAddEllipseInRect(circlePath, NULL, layerView2.bounds);
     layerView2.layer.shadowPath=circlePath;
     CGPathRelease(circlePath);
     
     */
    
    
    /*
     UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
     imageView.frame=CGRectMake(0, 300, 100, 100);
     [self.view addSubview:imageView];
     
     CALayer *maskLayer=[CALayer layer];
     maskLayer.frame=imageView.bounds;
     UIImage *maskImage=[UIImage imageNamed:@"minut"];
     maskLayer.contents=(__bridge id)maskImage.CGImage;
     imageView.layer.mask=maskLayer;
     */
    
    /*
     UIButton *button1=[self customButton];
     button1.center=CGPointMake(50, 400);
     
     [self.view addSubview:button1];
     
     UIButton *button2=[self customButton];
     button2.center=CGPointMake(250, 400);
     
     [self.view addSubview:button2];
     
     button2.layer.shouldRasterize=YES;
     button2.layer.rasterizationScale=[UIScreen mainScreen].scale;
     
     */
    
    /* 3D变换:m34设置
     UIView *imageView=[[UIView alloc]init];
     imageView.bounds=CGRectMake(0, 0, 100, 100);
     imageView.center=CGPointMake(WINDOWS.width/2, 400);
     [self.view addSubview:imageView];
     
     UIImage *image=[UIImage imageNamed:@"TestPic"];
     imageView.layer.contents=(__bridge id)image.CGImage;
     imageView.layer.contentsGravity=kCAGravityResizeAspect;
     
     CATransform3D transform=CATransform3DIdentity;
     transform.m34=-1.0/1000.0;//500~1000
     transform=CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
     imageView.layer.transform=transform;
     */
    
    /* 灭点 :sublayerTransformt统一设置子图层灭点
     UIView *contentview=[[UIView alloc]initWithFrame:CGRectMake(0, 300, WINDOWS.width, 200)];
     contentview.backgroundColor=[UIColor lightGrayColor];
     [self.view addSubview:contentview];
     
     
     UIView *layerView1=[[UIView alloc]initWithFrame:CGRectMake(50, 30, 100, 100)];
     layerView1.backgroundColor=[UIColor whiteColor];
     [contentview addSubview:layerView1];
     
     UIView *layerView2=[[UIView alloc]initWithFrame:CGRectMake(200, 30, 100, 100)];
     layerView2.backgroundColor=[UIColor whiteColor];
     [contentview addSubview:layerView2];
     
     UIImage *image=[UIImage imageNamed:@"TestPic"];
     layerView1.layer.contents=(__bridge id)image.CGImage;
     layerView1.layer.contentsGravity=kCAGravityResizeAspect;
     
     layerView2.layer.contents=(__bridge id)image.CGImage;
     layerView2.layer.contentsGravity=kCAGravityResizeAspect;
     
     CATransform3D perspective=CATransform3DIdentity;
     perspective.m34=-1.0/500.0;
     contentview.layer.sublayerTransform=perspective;
     
     CATransform3D transform1=CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
     layerView1.layer.transform=transform1;
     
     CATransform3D transform2=CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
     layerView2.layer.transform=transform2;
     
     */
    
    /* 背面
     UIView *contentview=[[UIView alloc]initWithFrame:CGRectMake(0, 300, WINDOWS.width, 200)];
     contentview.backgroundColor=[UIColor lightGrayColor];
     [self.view addSubview:contentview];
     
     
     UIView *layerView1=[[UIView alloc]initWithFrame:CGRectMake(50, 30, 100, 100)];
     layerView1.backgroundColor=[UIColor whiteColor];
     [contentview addSubview:layerView1];
     
     UIView *layerView2=[[UIView alloc]initWithFrame:CGRectMake(200, 30, 100, 100)];
     layerView2.backgroundColor=[UIColor whiteColor];
     [contentview addSubview:layerView2];
     
     UIImage *image=[UIImage imageNamed:@"TestPic"];
     layerView1.layer.contents=(__bridge id)image.CGImage;
     layerView1.layer.contentsGravity=kCAGravityResizeAspect;
     
     layerView2.layer.contents=(__bridge id)image.CGImage;
     layerView2.layer.contentsGravity=kCAGravityResizeAspect;
     
     CATransform3D perspective=CATransform3DIdentity;
     perspective.m34=-1.0/500.0;
     contentview.layer.sublayerTransform=perspective;
     
     CATransform3D transform1=CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
     layerView1.layer.transform=transform1;
     
     CATransform3D transform2=CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
     layerView2.layer.transform=transform2;
     */
    
    
    
    /** CAShapeLayer
     UIBezierPath *path=[[UIBezierPath alloc]init];
     [path moveToPoint:CGPointMake(175, 100)];
     [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
     
     [path moveToPoint:CGPointMake(150, 125)];
     [path addLineToPoint:CGPointMake(150, 175)];
     [path addLineToPoint:CGPointMake(125, 225)];
     
     [path moveToPoint:CGPointMake(150, 175)];
     [path addLineToPoint:CGPointMake(175, 225)];
     
     [path moveToPoint:CGPointMake(100, 150)];
     [path addLineToPoint:CGPointMake(200, 150)];
     
     
     
     //    CGRect rect =CGRectMake(50, 50, 100, 100);
     //    CGSize radius=CGSizeMake(20, 20);
     //    UIRectCorner corners=UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft;
     //    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
     //
     
     
     CAShapeLayer * shapeLayer=[CAShapeLayer layer];
     shapeLayer.strokeColor=[UIColor redColor].CGColor;
     shapeLayer.fillColor=[UIColor clearColor].CGColor;
     shapeLayer.lineWidth=5;
     shapeLayer.lineJoin=kCALineJoinRound;
     shapeLayer.lineCap=kCALineCapRound;
     shapeLayer.path=path.CGPath;
     [self.view.layer addSublayer:shapeLayer];
     */
    
    /* CATextlayer
     
     UIView *lableView=[[UIView alloc]initWithFrame:CGRectMake(100, 300, 200, 100)];
     [self.view addSubview:lableView];
     
     
     CATextLayer *textLayer=[CATextLayer layer];
     textLayer.frame=lableView.bounds;
     [lableView.layer addSublayer:textLayer];
     
     textLayer.foregroundColor=[UIColor blackColor].CGColor;
     textLayer.alignmentMode=kCAAlignmentJustified;
     textLayer.wrapped=YES;
     
     UIFont *font=[UIFont systemFontOfSize:15];
     
     CFStringRef fontName=(__bridge CFStringRef)font.fontName;
     CGFontRef fontRef=CGFontCreateWithFontName(fontName);
     textLayer.font=fontRef;
     textLayer.fontSize=font.pointSize;
     CGFontRelease(fontRef);
     
     NSString *text=@"wo cejoej fhueh huvheuvhuh hfuhuh huuh .fhuh huhu hcu . uhech i h uhuhuhu huhuhuh huhcwijdo .";
     textLayer.string=text;
     textLayer.contentsScale=[UIScreen mainScreen].scale;
     **/
    
    
    
    
    //富文本  iOS5及以下使用coretext.  建议用CAtextlayer
    
    /*
     UIView *lableView=[[UIView alloc]initWithFrame:CGRectMake(100, 300, 200, 100)];
     [self.view addSubview:lableView];
     
     CATextLayer *textLayer=[CATextLayer layer];
     textLayer.frame=lableView.bounds;
     textLayer.contentsScale=[UIScreen mainScreen].scale;
     [lableView.layer addSublayer:textLayer];
     
     textLayer.alignmentMode=kCAAlignmentJustified;
     textLayer.wrapped=YES;
     
     UIFont *font=[UIFont systemFontOfSize:15.0f];
     
     NSString *text=@"huu hihih ijiji iiiihhh jicihcji. cwu c i9uji9ujuu9u jicjeijdw9dc cjoejcovjjioej jijij.";
     NSMutableAttributedString *string=nil;
     string=[[NSMutableAttributedString alloc]initWithString:text];
     
     CFStringRef fontName=(__bridge CFStringRef)font.fontName;
     CGFloat fontSize=font.pointSize;
     CTFontRef fontRef=CTFontCreateWithName(fontName, fontSize, NULL);
     
     NSDictionary *attribs=@{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor};
     
     [string setAttributes:attribs range:NSMakeRange(0, [text length])];
     
     attribs=@{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
     (__bridge id)kCTUnderlineStyleAttributeName:@(kCTUnderlineStyleSingle),(__bridge id)kCTFontAttributeName:(__bridge id)fontRef
     };
     [string setAttributes:attribs range:NSMakeRange(6, 5)];
     
     CFRelease(fontRef);
     
     textLayer.string=string;
     */
    
    
    /* 自定义UIlable
     LayerLable *lable=[[LayerLable alloc]initWithFrame:CGRectMake(0, 300, 200, 50)];
     lable.text=@"我是你奶奶你妈妈们看妹妹";
     lable.textColor=[UIColor brownColor];
     [self.view addSubview:lable];
     
     */
    
    /* CATransformLayer  构造3D视图
     
     CATransform3D pt=CATransform3DIdentity;
     pt.m34=-1.0/1000;
     self.view.layer.sublayerTransform=pt;
     
     CATransform3D c1t=CATransform3DIdentity;
     c1t=CATransform3DTranslate(c1t, -100, 0, 0);
     CALayer *cube1=[self cubeWithTransform:c1t];
     [self.view.layer addSublayer:cube1];
     
     CATransform3D c2t=CATransform3DIdentity;
     c2t=CATransform3DTranslate(c2t, 100, 0, 0);
     c2t=CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
     c2t=CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
     CALayer *cube2=[self cubeWithTransform:c2t];
     [self.view.layer addSublayer:cube2];
     
     */
    
    /* CAGradientLayer 渐变颜色 使用了硬件加速
     CAGradientLayer *gradientLayer=[CAGradientLayer layer];
     gradientLayer.frame=self.view.bounds;
     [self.view.layer addSublayer:gradientLayer];
     
     gradientLayer.colors=@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor brownColor].CGColor];
     gradientLayer.locations=@[@0.0,@0.25,@0.5];
     
     gradientLayer.startPoint=CGPointMake(0, 0.5);
     gradientLayer.endPoint=CGPointMake(1, 0.5);
     
     */
    
    
    
    /* CAReplicatorLayer  重复图层
     
     CAReplicatorLayer *replicator=[CAReplicatorLayer layer];
     replicator.frame=self.view.bounds;
     [self.view.layer addSublayer:replicator];
     
     replicator.instanceCount=10;
     
     CATransform3D transform=CATransform3DIdentity;
     transform=CATransform3DTranslate(transform, 0, 20, 0);
     transform=CATransform3DRotate(transform, M_PI/5.0, 0, 0, 1);
     transform=CATransform3DTranslate(transform, 0, -20, 0);
     replicator.instanceTransform=transform;
     
     replicator.instanceBlueOffset=-0.1;
     replicator.instanceGreenOffset=-0.1;
     
     CALayer *layer=[CALayer layer];
     layer.frame=CGRectMake(100, 100, 10, 10);
     layer.backgroundColor=[UIColor whiteColor].CGColor;
     [replicator addSublayer:layer];
     
     
     */
    
    /* 反射
     
     ReflectionView *view=[[ReflectionView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
     view.backgroundColor=[UIColor greenColor];
     [view setUp];
     [self.view addSubview:view];
     */
    
    /* CAScrollLayer
     ScrollView *view=[[ScrollView alloc]initWithFrame:self.view.frame];
     
     [self.view addSubview:view];
     UIImage *image=[UIImage imageNamed:@"testScroll"];
     
     view.layer.contents=(__bridge id)image.CGImage;
     view.layer.contentsGravity=kCAGravityTop;
     */
    
    /* CATiledlayer 解决大图加载卡顿问题. 切割成小块;
     
     */
    
    //CaEmitterlayer
    /*
     CAEmitterLayer *emitter=[CAEmitterLayer layer];
     emitter.frame=self.view.bounds;
     [self.view.layer addSublayer:emitter];
     
     emitter.renderMode=kCAEmitterLayerAdditive;
     emitter.emitterPosition=CGPointMake(emitter.frame.size.width/2.0, emitter.frame.size.height/2.0);
     
     CAEmitterCell *cell=[[CAEmitterCell alloc]init];
     cell.contents=(__bridge id)[UIImage imageNamed:@"Spark"].CGImage;
     cell.birthRate=150;
     cell.lifetime=5.0;
     cell.color=[UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0 ].CGColor;
     
     cell.alphaSpeed=-0.4;
     cell.velocity=50;
     cell.velocityRange=50;
     cell.emissionRange=M_PI*2.0;
     emitter.emitterCells=@[cell];
     */
    
    
    /*  隐式动画
     self.colorlayer=[CALayer layer];
     self.colorlayer.frame=CGRectMake(50, 50, 100, 100);
     self.colorlayer.backgroundColor=[UIColor blueColor].CGColor;
     
     
     
     //    CATransition *transition=[CATransition animation];
     //    transition.type=kCATransitionPush;
     //    transition.subtype=kCATransitionFromLeft;
     //    self.colorlayer.actions=@{@"backgroundColor":transition};
     
     [self.view.layer addSublayer:self.colorlayer];
     
     UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
     button.frame=CGRectMake(50, 160, 100, 44);
     [button setTitle:@"改变颜色" forState:UIControlStateNormal];
     [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
     [button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:button];
     */
    
    //显示动画
    self.colorlayer=[CALayer layer];
    self.colorlayer.frame=CGRectMake(50, 50, 100, 100);
    self.colorlayer.backgroundColor=[UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:self.colorlayer];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(50, 160, 100, 44);
    [button setTitle:@"改变颜色" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
}



//斜切
- (CGAffineTransform)transformMakeShearWithX:(CGFloat)x withY:(CGFloat)y{
    CGAffineTransform transform=CGAffineTransformIdentity;
    transform.c=-x;
    transform.b=y;
    return transform;
}

- (UIButton *)customButton{
    CGRect frame=CGRectMake(0, 0, 150, 50);
    UIButton *button=[[UIButton alloc]initWithFrame:frame];
    button.backgroundColor=[UIColor lightGrayColor];
    button.layer.cornerRadius=10;
    button.alpha=0.5;
    
    frame=CGRectMake(20, 10, 110, 30);
    UILabel *lable=[[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor=[UIColor lightGrayColor];
    lable.text=@"Hello World";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.alpha=0.5;
    [button addSubview:lable];
    return button;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self.view];
    
    //警告:当改变了zPosition的值, 图层顺序发生改变,但不能改变触摸事件的被处理的顺序, 此时会有冲突.
    /** 第一种判断点击位置
     
    point=[self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:point]) {
        point=[blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([blueLayer containsPoint:point]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"click in blueView" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"click in whiteView" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }
    }
     */
    /** 使用hitTest返回当前图层
     CALayer *layer=[self.layerView.layer hitTest:point];
     if (layer==blueLayer) {
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"click in blueView" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
     [alert show];
     }else if (layer==self.layerView.layer){
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"click in whiteView" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
     [alert show];
     }
     */
    
    
    
}
- (void)addImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer{
    layer.contents=(__bridge id)image.CGImage;
    layer.contentsGravity=kCAGravityResizeAspect;
    layer.contentsRect=rect;
}
- (void)addImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer{
    layer.contents=(__bridge id)image.CGImage;
    layer.contentsCenter=rect;
    
}
#pragma mark ------CALayerDelegate--------
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
    
    
}


- (void)tick{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components=[calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
    CGFloat hourAngle=(components.hour/12.0)*M_PI*2.0;
    CGFloat minsAngle=(components.minute/60.0)*M_PI*2.0;
    CGFloat secondAngle=(components.second/60.0)*M_PI*2.0;
    hourImgV.transform=CGAffineTransformMakeRotation(hourAngle);
    minutImgV.transform=CGAffineTransformMakeRotation(minsAngle);
    secondImgV.transform=CGAffineTransformMakeRotation(secondAngle);
    
    
}

/* 隐式动画
 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 CGPoint point=[[touches anyObject]locationInView:self.view];
 if ([self.colorlayer.presentationLayer hitTest:point]) {
 CGFloat red=arc4random()/(CGFloat)INT_MAX;
 CGFloat green=arc4random()/(CGFloat)INT_MAX;
 CGFloat blue=arc4random()/(CGFloat)INT_MAX;
 self.colorlayer.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
 }else{
 [CATransaction begin];
 [CATransaction setAnimationDuration:4.0];
 
 self.colorlayer.position=point;
 [CATransaction commit];
 
 }
 
 
 }
 
 
 */
- (void)changeColor{
    
    CGFloat red=arc4random()/(CGFloat)INT_MAX;
    CGFloat green=arc4random()/(CGFloat)INT_MAX;
    CGFloat blue=arc4random()/(CGFloat)INT_MAX;
    UIColor *color=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CABasicAnimation *animation=[CABasicAnimation animation];
    animation.keyPath=@"backgroundColor";
    animation.toValue=(__bridge id)color.CGColor;
    [self applyBasicAnimation:animation tolayer:self.colorlayer];
    
}
- (void)applyBasicAnimation:(CABasicAnimation *)animation tolayer:(CALayer *)layer{
    animation.fromValue=[(layer.presentationLayer? layer.presentationLayer:layer) valueForKeyPath:animation.keyPath];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    [layer addAnimation:animation forKey:nil];
    
}

- (CALayer *)faceWithTransform:(CATransform3D)transform{
    CALayer *face=[CALayer layer];
    face.frame=CGRectMake(-50, -50, 100, 100);
    
    CGFloat red=(rand()/(double)INT_MAX);
    CGFloat green=(rand()/(double)INT_MAX);
    CGFloat blue=(rand()/(double)INT_MAX);
    
    face.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    face.transform=transform;
    return face;
}
- (CALayer *)cubeWithTransform:(CATransform3D)transform{
    CATransformLayer *cube=[CATransformLayer layer];
    
    CATransform3D ct=CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct=CATransform3DMakeTranslation(50, 0, 0);
    ct=CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct=CATransform3DMakeTranslation(0, -50, 0);
    ct=CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct=CATransform3DMakeTranslation(0, 50, 0);
    ct=CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct=CATransform3DMakeTranslation(-50, 0, 0);
    ct=CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    
    cube.position=CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    cube.transform=transform;
    
    return cube;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
