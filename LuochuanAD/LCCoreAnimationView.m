//
//  LCCoreAnimationView.m
//  LuochuanAD
//
//  Created by care on 2018/1/16.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "LCCoreAnimationView.h"

@implementation MYLayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(nonnull CGContextRef)ctx{
    
    /*
     *  第三种, 代理, UIKit:UIBezierPath
     */
//    UIGraphicsPushContext(ctx);
//    UIBezierPath *p =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 64, 100, 100)];
//    [[UIColor redColor] setFill];
//    [p fill];
//    UIGraphicsPopContext();
    
    /*
     * 第四种, 代理, CoreGraphics
     */
//    CGContextAddEllipseInRect(ctx, CGRectMake(0, 64, 100, 100));
//    CGContextSetFillColorWithColor(ctx, [UIColor brownColor].CGColor);
//    CGContextFillPath(ctx);
    
    
    
    
}

@end


@implementation LCCoreAnimationView

- (void)drawRect:(CGRect)rect{
    
    /*
     * 第一种,drawRect   UIKit: UIbezierPath
     */
//    UIBezierPath *p=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 64, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [p fill];
    
    
    /*
     * 第二种,drawRect  CoreGraphics
     */
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(con, CGRectMake(0, 64, 100, 100));
//    CGContextSetFillColorWithColor(con, [UIColor greenColor].CGColor);
//    CGContextFillPath(con);
    
    
    /*
     * 第五种 drawrect UIKit :UIbezierPath UIimage
     */
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
//    UIBezierPath *p=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor grayColor] setFill];
//    [p fill];
//    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self addSubview:[[UIImageView alloc]initWithImage:image]];
    
    
    /*
     *第六种 drawRect CoreGraphics
     */
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 100, 100));
//    CGContextSetFillColorWithColor(con, [UIColor cyanColor].CGColor);
//    CGContextFillPath(con);
//    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self addSubview:[[UIImageView alloc]initWithImage:image]];
    
    //常用的绘图操作
    
    /*
     * 擦除一段区域
     */
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
//    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
//    CGContextClearRect(ctx, CGRectMake(0, 0, 30, 30));
    
    /*
     * 绘制一个箭头
     */
//    CGContextRef con=UIGraphicsGetCurrentContext();
//
//    //绘制一个黑色垂直的黑色线
//    CGContextMoveToPoint(con, 100, 100);
//    CGContextAddLineToPoint(con, 100, 19);
//    CGContextSetLineWidth(con, 20);
//    CGContextStrokePath(con);
//    //绘制红色三角箭头
//    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
//    CGContextMoveToPoint(con, 80, 25);
//    CGContextAddLineToPoint(con, 100, 0);
//    CGContextAddLineToPoint(con, 120, 25);
//    CGContextFillPath(con);
//    //裁剪一个三角形,使用清除混合模式
//    CGContextMoveToPoint(con, 90, 101);
//    CGContextAddLineToPoint(con, 100, 90);
//    CGContextAddLineToPoint(con, 110, 101);
//    CGContextSetBlendMode(con, kCGBlendModeClear);
//    CGContextFillPath(con);
    
    
    /*
     *绘制一个箭头
     */
//    UIBezierPath *p=[UIBezierPath bezierPath];
//    [p moveToPoint:CGPointMake(100, 100)];
//    [p addLineToPoint:CGPointMake(100, 19)];
//    [p setLineWidth:20];
//    [p stroke];
//
//    [[UIColor redColor]set];
//    [p removeAllPoints];
//    [p moveToPoint:CGPointMake(80, 25)];
//    [p addLineToPoint:CGPointMake(100, 0)];
//    [p addLineToPoint:CGPointMake(120, 25)];
//    [p fill];
//
//    [p removeAllPoints];
//    [p moveToPoint:CGPointMake(90, 101)];
//    [p addLineToPoint:CGPointMake(100, 90)];
//    [p addLineToPoint:CGPointMake(110, 101)];
//    [p fillWithBlendMode:kCGBlendModeClear alpha:1.0];
    
    /*
     * 绘制带有圆角的矩形
     */
    
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
//    CGContextSetLineWidth(ctx, 3);
//    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(10, 10)];
//    [path stroke];
    
    
    /*
     *绘制一个箭头
     */
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    //在上下文裁剪区域中挖掉一个三角形的空
//    CGContextMoveToPoint(con, 90, 100);
//    CGContextAddLineToPoint(con, 100, 90);
//    CGContextAddLineToPoint(con, 110, 100);
//    CGContextClosePath(con);
//    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
//    //使用奇偶规则,裁剪区域为矩形减去三角形区域
//    CGContextEOClip(con);
//    //绘制垂线
//    CGContextMoveToPoint(con, 100, 100);
//    CGContextAddLineToPoint(con, 100, 19);
//    CGContextSetLineWidth(con, 20);
//    CGContextStrokePath(con);
//    //画红色箭头
//    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
//    CGContextMoveToPoint(con, 80, 25);
//    CGContextAddLineToPoint(con, 100, 0);
//    CGContextAddLineToPoint(con, 120, 25);
//    CGContextFillPath(con);
    
    /*
     * 绘制一个渐变的箭头
     */
    
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    //在上下文裁剪区域中挖掉一个三角形的空
//    CGContextMoveToPoint(con, 90, 100);
//    CGContextAddLineToPoint(con, 100, 90);
//    CGContextAddLineToPoint(con, 110, 100);
//    CGContextClosePath(con);
//    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
//    //使用奇偶规则,裁剪区域为矩形减去三角形区域
//    CGContextEOClip(con);
//    //绘制垂线
//    CGContextMoveToPoint(con, 100, 100);
//    CGContextAddLineToPoint(con, 100, 19);
//    CGContextSetLineWidth(con, 20);
//    //使用路径的描边版本替换图形的上下文的路径
//    CGContextReplacePathWithStrokedPath(con);
//    //对路径的描边版本实施裁剪
//    CGContextClip(con);
//    //绘制渐变
//    CGFloat locs[3]={0.0,0.5,1.0};
//    CGFloat colors[12]={
//        0.3,0.3,0.3,0.8,
//        0,0,0,1,
//        0.3,0.3,0.3,0.8
//    };
//    CGColorSpaceRef sp=CGColorSpaceCreateDeviceGray();
//    CGGradientRef grad=CGGradientCreateWithColorComponents(sp, colors, locs, 3);
//    CGContextDrawLinearGradient(con, grad, CGPointMake(89, 0), CGPointMake(111, 0), 0);
//    CGColorSpaceRelease(sp);
//    CGGradientRelease(grad);
//
//    //画红色箭头
//    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
//    CGContextMoveToPoint(con, 80, 25);
//    CGContextAddLineToPoint(con, 100, 0);
//    CGContextAddLineToPoint(con, 120, 25);
//    CGContextFillPath(con);
    
    /*
     *绘制不同颜色的箭头
     */
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    //在上下文裁剪区域中挖掉一个三角形的空
//    CGContextMoveToPoint(con, 90, 100);
//    CGContextAddLineToPoint(con, 100, 90);
//    CGContextAddLineToPoint(con, 110, 100);
//    CGContextClosePath(con);
//    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
//    //使用奇偶规则,裁剪区域为矩形减去三角形区域
//    CGContextEOClip(con);
//    //绘制垂线
//    CGContextMoveToPoint(con, 100, 100);
//    CGContextAddLineToPoint(con, 100, 19);
//    CGContextSetLineWidth(con, 20);
//    CGContextStrokePath(con);
//    //画不同颜色的箭头
////    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
//    CGColorSpaceRef sp2=CGColorSpaceCreatePattern(NULL);
//    CGContextSetFillColorSpace(con, sp2);
//    CGColorSpaceRelease(sp2);
//    CGPatternCallbacks callback={0,&drawStripes,NULL};
//    CGAffineTransform tr=CGAffineTransformIdentity;
//    CGPatternRef patt=CGPatternCreate(NULL, CGRectMake(0, 0, 4, 4), tr, 4, 4, kCGPatternTilingConstantSpacingMinimalDistortion, true, &callback);
//    CGFloat alph=1.0;
//    CGContextSetFillPattern(con, patt, &alph);
//    CGPatternRelease(patt);
//
//    CGContextMoveToPoint(con, 80, 25);
//    CGContextAddLineToPoint(con, 100, 0);
//    CGContextAddLineToPoint(con, 120, 25);
//    CGContextFillPath(con);
    
    
    [self drawLine2];
    
}

void drawStripes (void *info,CGContextRef con){
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0, 0, 4, 4));
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0, 0, 4, 2));
}


- (void)drawAll{//平移,旋转,缩放
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 300, 300);
    CGContextRotateCTM(context, M_PI_4);
    CGContextScaleCTM(context, 0.5, 0.75);
    [self drawShapeRect2];
    CGContextRestoreGState(context);
    [self drawShapeRect2];
    
}
- (void)drawShapeRect2{//绘制矩形2
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(50, 50, 100, 100));
    [[UIColor redColor] setFill];
    [[UIColor darkGrayColor] setStroke];
    CGContextFillRect(context, CGRectMake(50, 50, 100, 100));
    CGContextStrokeRect(context, CGRectMake(50, 50, 100, 100));
    
    
}
- (void)drawImage{//绘制图像
    UIImage *image=[UIImage imageNamed:@"book_cover.png"];
    [image drawAtPoint:CGPointZero];
    CGRect rect=CGRectMake(0, 0, 320, 460);
    [image drawInRect:rect];
    //平铺
    [image drawAsPatternInRect:rect];
    
}
- (void)drawText{//绘制文本
    [[UIColor redColor] set];
    NSString *text=@"hello world!hello world!hello world!hello world!";
    UIFont *font=[UIFont fontWithName:@"Marker Felt" size:20];
    [text drawAtPoint:CGPointMake(50, 50) withAttributes:nil];
    CGRect rect=CGRectMake(50, 100, 200, 300);
    [[UIColor blueColor]set];
    UIRectFill(rect);
    [[UIColor redColor]set];
    [text drawInRect:rect withAttributes:nil];
    NSLog(@"%@",[UIFont familyNames]);
    
    
}
- (void)drawShapGradient{//绘制渐变
    CGContextRef context=UIGraphicsGetCurrentContext();
    //定义渐变引用
    CGGradientRef gradient;
    //定义色彩空间引用
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    //定义颜色渐变组件
    CGFloat components[8]={1.0,0,0,1,0,0,1.0,1};
    //定义颜色渐变位置
    CGFloat locations[2]={0,1.0};
    //创建颜色渐变
    gradient=CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    //创建贝塞尔曲线
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 150, 150)];
    //添加剪切路径
    [path addClip];
    //绘制线性渐进
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(50, 50), CGPointMake(150, 150), kCGGradientDrawsAfterEndLocation);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(100, 100), 0, CGPointMake(100, 100), 100, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    //释放渐变引用
    CGGradientRelease(gradient);
    
}
- (void)drawShapeArc{//绘制圆弧
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddArc(context, 100, 100, 50, M_PI_2, -M_PI_2, 0);
    CGContextStrokePath(context);
    
}
- (void)drawShapeCircle2{//绘制随机圆形
    CGContextRef context=UIGraphicsGetCurrentContext();
    [[UIColor darkGrayColor] set];
    for (NSInteger i=0; i<10; i++) {
        NSInteger x=arc4random()%220+50;
        NSInteger y=arc4random()%360+50;
        NSInteger r=arc4random()%40+10;
        CGContextFillEllipseInRect(context, CGRectMake(x, y, r, r));
        
    }
    
}
- (void)drawShapeTriangle{//绘制三角形
    CGContextRef context=UIGraphicsGetCurrentContext();
    [[UIColor yellowColor]set];
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 150, 50);
    CGContextFillPath(context);
}
- (void)drawShapeRect1{//绘制矩形1
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(50, 50, 100, 100));
    CGContextFillPath(context);
    
}
- (void)drawLine1{//绘制直线一
    CGContextRef context=UIGraphicsGetCurrentContext();
    //创建路径
    CGMutablePathRef path=CGPathCreateMutable();
    //设置路径起点
    CGPathMoveToPoint(path, NULL, 50, 50);
    //增加路径内容
    CGPathAddLineToPoint(path, NULL, 50, 420);
    CGPathAddLineToPoint(path, NULL, 270, 420);
    CGPathAddLineToPoint(path, NULL, 270, 50);
    //关闭路径
    CGPathCloseSubpath(path);
    //添加路径到上下文
    CGContextAddPath(context, path);
    //设置边线颜色
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    //设置填充颜色
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    //设置线宽
    CGContextSetLineWidth(context, 10);
    //设置线段连接样式
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    //设置线段首位样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置虚线
    CGFloat lengths[]={20,100};
    CGContextSetLineDash(context, 100, lengths, 2);
    //绘制路径
    CGContextDrawPath(context, kCGPathEOFill);
    //释放
    CGPathRelease(path);
    
}
- (void)drawLine2{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 150, 50);
    
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 10);
    
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 150, 50);
    CGContextStrokePath(context);
    
}
@end
