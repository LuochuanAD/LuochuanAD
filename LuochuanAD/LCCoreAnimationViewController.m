//
//  LCCoreAnimationViewController.m
//  LuochuanAD
//
//  Created by care on 2018/1/15.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "LCCoreAnimationViewController.h"
#import "LCCoreAnimationView.h"
#import "LCCoreAnimationManager.h"
@interface LCCoreAnimationViewController ()

@end

@implementation LCCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    LCCoreAnimationView *coreView=[[LCCoreAnimationView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height-64)];
    coreView.backgroundColor=[UIColor clearColor];
    
    /*
     * 第三种,第四种  暂时不可用
     */
//    CALayer *myLayer=[CALayer layer];
//    MYLayerDelegate *layerDelegate=[[MYLayerDelegate alloc]init];
//    @weakify(layerDelegate)
//
//    myLayer.delegate=weak_layerDelegate;
//    [coreView.layer addSublayer:myLayer];
//    [coreView setNeedsDisplay];
    [self.view addSubview:coreView];
    
    
    
    
    
    
    /*
     * 基础动画
     */
    
//    CABasicAnimation *animation=[CABasicAnimation animation];
//    animation.keyPath=@"position.x";
//    animation.fromValue=@77;
//    animation.toValue=@455;
//    animation.duration=5;
//    [coreView.layer addAnimation:animation forKey:@"basic"];
//    
//    coreView.layer.position=CGPointMake(455, coreView.center.y);
//    
//    LCCoreAnimationView *coreView2=[[LCCoreAnimationView alloc]initWithFrame:CGRectMake(0, 64, 150,150)];
//    coreView2.backgroundColor=[UIColor clearColor];
//    [self.view addSubview:coreView2];
//    
//    animation.beginTime=CACurrentMediaTime()+0.5;
//    [coreView2.layer addAnimation:animation forKey:@"basic"];
//    coreView2.layer.position=CGPointMake(455, coreView2.center.y);
    
    /*
     * 关键帧动画 颤抖
     */
//    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
//    animation.keyPath=@"position.x";
//    animation.values=@[@0,@10,@-10,@10,@0];
//    animation.keyTimes=@[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
//    animation.duration=4;
//    animation.additive=YES;
//    [coreView.layer addAnimation:animation forKey:@"shake"];
    
    /*
     * 关键帧动画 沿路径的动画
     */
//    CGRect boundingRect=CGRectMake(-100, -100, 200, 200);
//    CAKeyframeAnimation *orbit=[CAKeyframeAnimation animation];
//    orbit.keyPath=@"position";
//    orbit.path=CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
//    orbit.duration=4;
//    orbit.additive=YES;
//    orbit.repeatCount=9999;
//    orbit.calculationMode=kCAAnimationPaced;
//    orbit.rotationMode=kCAAnimationRotateAuto;
//    [coreView.layer addAnimation:orbit forKey:@"orbit"];
    
    /*
     * 关键帧动画
     */
//    CABasicAnimation *animation=[CABasicAnimation animation];
//    animation.keyPath=@"position.x";
//    animation.fromValue=@50;
//    animation.toValue=@150;
//    animation.duration=2;
//    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [coreView.layer addAnimation:animation forKey:@"basic"];
    
    
    
    
    
    
    
//    [self operationImagesForFilter];
    
//    UIImage *currentImage=[self createImage];
//
//    UIImageView *currentImageView=[[UIImageView alloc]initWithImage:currentImage];
//    [LCCoreAnimationManager heartbeatView:currentImageView duration:5];
//
//    [self.view addSubview:currentImageView];
    
    
    
    
    

}
//创建图像的缩略图
- (UIImage *)createImage{
    UIGraphicsBeginImageContext(CGSizeMake(220, 400));
    UIImage *image=[UIImage imageNamed:@"book_cover.png"];
    [image drawInRect:CGRectMake(0, 70, 220, 400)];
    NSString *text=@"水印文字";
    UIFont *font=[UIFont systemFontOfSize:12];
    [[UIColor redColor]set];
    [text drawInRect:CGRectMake(30, 170, 220, 30) withAttributes:@{NSFontAttributeName:font}];
    UIImage *result=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}


//UIImage 常用的绘图操作

- (void)operationImagesForTranslation{//平移
    UIImage *image=[UIImage imageNamed:@"book_cover.png"];
    CGSize sz=[image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*2, sz.height), NO, 0);
    [image drawAtPoint:CGPointMake(0,0)];
    [image drawAtPoint:CGPointMake(sz.width, 0)];
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *currentImageView=[[UIImageView alloc]initWithImage:currentImage];
    [self.view addSubview:currentImageView];
    currentImageView.center=self.view.center;
}
- (void)operationImagesForZoom{//缩放
    UIImage *image=[UIImage imageNamed:@"book_cover.png"];
    CGSize sz=[image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*2, sz.height*2), NO, 0);
    [image drawInRect:CGRectMake(0, 0, sz.width*2, sz.height*2)];
    [image drawInRect:CGRectMake(sz.width/2, sz.height/2, sz.width, sz.height) blendMode:kCGBlendModeMultiply alpha:1.0];
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *currentImageView=[[UIImageView alloc]initWithImage:currentImage];
    [self.view addSubview:currentImageView];
    currentImageView.center=self.view.center;
    
}
- (void)operationImagesForTailor{//裁剪
    UIImage *image=[UIImage imageNamed:@"book_cover.png"];
    CGSize sz=[image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width/2.0, sz.height), NO, 0);
    [image drawAtPoint:CGPointMake(-sz.width/2.0, 0)];
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *currentImageView=[[UIImageView alloc]initWithImage:currentImage];
    [self.view addSubview:currentImageView];
    currentImageView.center=self.view.center;
    
}
- (void)operationImagesForSplit{//拆分
    UIImage *image=[UIImage imageNamed:@"book_cover.png"];
    CGSize sz=CGSizeMake(CGImageGetWidth([image CGImage]), CGImageGetHeight([image CGImage]));
    CGImageRef imageLeft=CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, sz.width/2.0, sz.height));
    CGImageRef imageRight=CGImageCreateWithImageInRect([image CGImage], CGRectMake(sz.width/2.0, 0, sz.width/2.0, sz.height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*1.5, sz.height), NO, 0);
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextDrawImage(con, CGRectMake(0, 0, sz.width/2.0, sz.height),[self upsideDownCGImageRef:imageLeft]);
    CGContextDrawImage(con, CGRectMake(sz.width, 0, sz.width/2.0, sz.height), [self upsideDownCGImageRef:imageRight]);
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageLeft);
    CGImageRelease(imageRight);
    UIImageView *currentImageView=[[UIImageView alloc]initWithImage:currentImage];
    [self.view addSubview:currentImageView];
    currentImageView.center=self.view.center;
    
    
}
- (CGImageRef)upsideDownCGImageRef:(CGImageRef)im{
    CGSize sz=CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    UIGraphicsBeginImageContextWithOptions(sz, NO, 0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, sz.width, sz.height),im);
    CGImageRef result=[UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    return result;
}

- (void)operationImagesForFilter{//滤镜
    UIImage *moi=[UIImage imageNamed:@"book_cover.png"];
    CIImage *moi2=[[CIImage alloc]initWithCGImage:moi.CGImage];
    CIFilter *grad=[CIFilter filterWithName:@"CIRadialGra"];
    CIVector *center=[CIVector vectorWithX:moi.size.width/2 Y:moi.size.height/2];
    [grad setValue:center forKey:@"inputCenter"];
    
    CIFilter *dark=[CIFilter filterWithName:@"CIDarkenBlendMode" keysAndValues:@"inputImage",grad.outputImage,@"inputBackgroundImage",moi2, nil];
    CIContext *c =[CIContext contextWithOptions:nil];
    CGImageRef moi3=[c createCGImage:dark.outputImage fromRect:moi2.extent];
    UIImage *moi4=[UIImage imageWithCGImage:moi3 scale:moi.scale orientation:moi.imageOrientation];
    CGImageRelease(moi3);
    UIImageView *currentImageView=[[UIImageView alloc]initWithImage:moi4];
    [self.view addSubview:currentImageView];
    currentImageView.center=self.view.center;
    
}
//返回一张黑白像素的图片
- (UIImage *)processUsingCoreGraphics:(UIImage *)input{
    CGRect imageRect={CGPointZero,input.size};
    NSInteger inputWith=CGRectGetWidth(imageRect);
    NSInteger inputHeight=CGRectGetHeight(imageRect);
    CGColorSpaceRef colorSpaceRef=CGColorSpaceCreateDeviceGray();
    CGContextRef content=CGBitmapContextCreate(nil, inputWith, inputHeight, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CGContextDrawImage(content, imageRect, [input CGImage]);
    CGImageRef imageRef=CGBitmapContextCreateImage(content);
    UIImage *image=[UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(content);
    CGImageRelease(imageRef);
    return image;
}
//- (NSString *)getDate{
//    NSArray *arrweek=@[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",];
//    NSDateComponents *compents=[[NSCalendar autoupdatingCurrentCalendar] component:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
//    NSInteger weekday=[compents weekday];
//    NSInteger month=[compents month];
//    NSInteger day=[compents day];
//    NSString *week=[arrweek objectAtIndex:(weekday-1)];
//    return [NSString stringWithFormat:@"%li月%li日%@",(long)month,(long)day,week];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
