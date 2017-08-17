//
//  UIView+UIImage.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "UIView+UIImage.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (UIImage)
- (UIImage *)image{
    CGSize imageSize=[self bounds].size;
    if (NULL != &UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }else{
        UIGraphicsBeginImageContext(imageSize);
    }
    CGContextRef context=UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)]||[window screen]==[UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
            [[window layer]renderInContext:context];
            CGContextRestoreGState(context);
        }
    }
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
