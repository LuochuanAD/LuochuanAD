//
//  LCCoreAnimationManager.m
//  LuochuanAD
//
//  Created by care on 2018/1/19.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "LCCoreAnimationManager.h"

@implementation LCCoreAnimationManager

/*
 * 截取屏幕上面指定区域,返回UIImage对象
 */
+ (UIImage *)imageFromView:(UIView *)theView{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/*
 * 将gif图片解析成image数组
 */
- (NSMutableArray *)praseGIFDataToImageArray:(NSData *)data{
    NSMutableArray *frames=[[NSMutableArray alloc]init];
    CGImageSourceRef src=CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime=0.f;
    if (src) {
        size_t count=CGImageSourceGetCount(src);
        frames=[NSMutableArray arrayWithCapacity:count];
        for (size_t i=0; i<count; i++) {
            CGImageRef img=CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties=(NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties=[properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime=[frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime +=[delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}
/*
 *  心跳动画
 */
+ (void)heartbeatView:(UIView *)view duration:(CGFloat)fDuration{
    [[self class] heartbeatView:view duration:fDuration maxSize:1.4f durationPerBeat:0.5f];
}
+ (void)heartbeatView:(UIView *)view duration:(CGFloat)fDuration maxSize:(CGFloat)fMaxSize durationPerBeat:(CGFloat)fDurationPerBeat{
    if (view && (fDurationPerBeat>0.1f)) {
        CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
        CATransform3D scale1=CATransform3DMakeScale(0.8, 0.8, 1);
        CATransform3D scale2=CATransform3DMakeScale(fMaxSize, fMaxSize, 1);
        CATransform3D scale3=CATransform3DMakeScale(fMaxSize-0.3f, fMaxSize-0.3f, 1);
        CATransform3D scale4=CATransform3DMakeScale(1.0, 1.0, 1);
        NSArray *frameValues=@[[NSValue valueWithCATransform3D:scale1],[NSValue valueWithCATransform3D:scale2],[NSValue valueWithCATransform3D:scale3],[NSValue valueWithCATransform3D:scale4]];
        [animation setValues:frameValues];
        NSArray *frameTimes=@[[NSNumber numberWithFloat:0.05],[NSNumber numberWithFloat:0.2],[NSNumber numberWithFloat:0.6],[NSNumber numberWithFloat:1.0]];
        [animation setKeyTimes:frameTimes];
        animation.fillMode=kCAFillModeForwards;
        animation.duration=fDurationPerBeat;
        animation.repeatCount=fDuration/fDurationPerBeat;
        [view.layer addAnimation:animation forKey:@"heartbeatView"];
        
    }
    
}

#pragma mark ------------------------------------------------------------------
/*
 *  @param type 动画过度类型
 *
 *  @param subType 动画过渡方向(子类型)
 *
 *  @param duration 动画持续时间
 *
 *  @param timingFunction 动画定时函数属性
 *
 *  @param theView 需要添加动画的view
 */
+ (void)showAnimationType:(NSString *)type withSubType:(NSString *)subType duration:(CFTimeInterval)duration timingFunction:(NSString *)timingFunction view:(UIView *)theView{
    CATransition *animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=duration;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:timingFunction];
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.type=type;
    animation.subtype=subType;
    [theView.layer addAnimation:animation forKey:nil];
    
}

//reveal
+ (void)animationRevealFromBottom:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationRevealFromTop:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationRevealFromLeft:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationRevealFromRight:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}


//渐隐渐消
+ (void)animationEaseIn:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
    
}
+ (void)animationEaseOut:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}
//翻转
+ (void)animationFlipFromLeft:(UIView *)view{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    [UIView commitAnimations];
}
+ (void)animationFlipFromRight:(UIView *)view{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:NO];
    [UIView commitAnimations];
    
}
//翻页
+ (void)animationCurlUp:(UIView *)view{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:NO];
    [UIView commitAnimations];
}
+ (void)animationCurlDown:(UIView *)view{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:NO];
    [UIView commitAnimations];
}
//push
+ (void)animationPushUp:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    [view.layer addAnimation:animation forKey:nil];
    
}
+ (void)animationPushDown:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationPushLeft:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationPushRight:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [view.layer addAnimation:animation forKey:nil];
}
//move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration{
    CATransition *animation=[CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    [view.layer addAnimation:animation forKey:nil];
    
}
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration{
    CATransition *animation=[CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromBottom];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationMoveLeft:(UIView *)view duration:(CFTimeInterval)duration{
    CATransition *animation=[CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationMoveRight:(UIView *)view duration:(CFTimeInterval)duration{
    CATransition *animation=[CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    [view.layer addAnimation:animation forKey:nil];
}


//各种旋转缩放效果
+ (void)animationRotateAndScaleEffects:(UIView *)view{
    [UIView animateWithDuration:0.35f animations:^{
        view.transform=CGAffineTransformMakeScale(0.001, 0.001);
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
        animation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1.0, 0, 0)];
        animation.duration=0.45f;
        animation.repeatCount=1;
        [view.layer addAnimation:animation forKey:nil];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35f animations:^{
            view.transform=CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}
//旋转提示缩小放大效果
+ (void)animationRotateAndScaleDownUp:(UIView *)view{
    CABasicAnimation *rotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue=[NSNumber numberWithFloat:(2*M_PI)];
    rotationAnimation.duration=0.35f;
    rotationAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *scaleAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration=0.35f;
    scaleAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
    animationGroup.duration=0.35f;
    animationGroup.autoreverses=YES;
    animationGroup.repeatCount=10;
    animationGroup.animations=@[rotationAnimation,scaleAnimation];
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

/*
 *  下面用到的某些属性在当前api里是不合法的.但也是可以用的
 */
+ (void)animationFlipFromTop:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromTop"];
    [view.layer addAnimation:animation forKey:nil];
    
}
+ (void)animationFlipFromBottom:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromBottom"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationCubeFromLeft:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromLeft"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationCubeFromRight:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromRight"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationCubeFromTop:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromTop"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationCubeFromBottom:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromBottom"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationSuckEffect:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationRippleEffect:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationCameraOpen:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameralriHollowOpen"];
    [animation setSubtype:@"fromRight"];
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)animationCameraClose:(UIView *)view{
    CATransition *animation=[CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameralriHollowClose"];
    [animation setSubtype:@"fromRight"];
    [view.layer addAnimation:animation forKey:nil];
    
}
#pragma mark ---------矩阵变换--------------
+ (UIImage *)transformImage:(UIImage *)aImage{
    CGImageRef imageRef=aImage.CGImage;
    CGFloat width=CGImageGetWidth(imageRef);
    CGFloat height=CGImageGetHeight(imageRef);
    CGAffineTransform transform=CGAffineTransformIdentity;
    CGRect bounds=CGRectMake(0, 0, width, height);
    CGFloat scaleRotio=1;
    CGFloat boundHeight;
    UIImageOrientation orient=aImage.imageOrientation;
    switch (orient) {
        case UIImageOrientationUp:
        {
            transform=CGAffineTransformIdentity;
        }
            break;
        case UIImageOrientationUpMirrored:
        {
            transform=CGAffineTransformMakeTranslation(width, 0.0);
            transform=CGAffineTransformScale(transform, -1.0, 1.0);
        }
            break;
        case UIImageOrientationDown:
        {
            transform=CGAffineTransformMakeTranslation(width, height);
            transform=CGAffineTransformRotate(transform, M_PI);
        }
            break;
        case UIImageOrientationDownMirrored:
        {
            transform=CGAffineTransformMakeTranslation(0.0, height);
            transform=CGAffineTransformScale(transform, 1.0, -1.0);
        }
            break;
        case UIImageOrientationLeft:
        {
            boundHeight=bounds.size.height;
            bounds.size.height=bounds.size.width;
            bounds.size.width=boundHeight;
            transform=CGAffineTransformMakeTranslation(0.0, width);
            transform=CGAffineTransformRotate(transform, 3.0*M_PI/2.0);
        }
            break;
        case UIImageOrientationLeftMirrored:
        {
            boundHeight=bounds.size.height;
            bounds.size.height=bounds.size.width;
            bounds.size.width=boundHeight;
            transform=CGAffineTransformMakeTranslation(height, width);
            transform=CGAffineTransformScale(transform, -1.0, 1.0);
            transform=CGAffineTransformRotate(transform, 3.0*M_PI/2.0);
        }
            break;
        case UIImageOrientationRight:
        {
            boundHeight=bounds.size.height;
            bounds.size.height=bounds.size.width;
            bounds.size.width=boundHeight;
            transform=CGAffineTransformMakeTranslation(height, 0.0);
            transform=CGAffineTransformRotate(transform, M_PI/2.0);
            
        }
            break;
        case UIImageOrientationRightMirrored:
        {
            boundHeight=bounds.size.height;
            bounds.size.height=bounds.size.width;
            bounds.size.width=boundHeight;
            transform=CGAffineTransformMakeScale(-1.0, 1.0);
            transform=CGAffineTransformRotate(transform, M_PI/2.0);
        }
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    if (orient==UIImageOrientationRight||orient==UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRotio, scaleRotio);
        CGContextTranslateCTM(context, -height, 0);
        
    }else{
        CGContextScaleCTM(context, scaleRotio, -scaleRotio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imageRef);
    UIImage *imageCopy=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}



@end
