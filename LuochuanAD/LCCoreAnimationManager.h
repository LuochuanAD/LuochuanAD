//
//  LCCoreAnimationManager.h
//  LuochuanAD
//
//  Created by care on 2018/1/19.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface LCCoreAnimationManager : NSObject<CAAnimationDelegate>
+ (UIImage *)imageFromView:(UIView *)theView;
- (NSMutableArray *)praseGIFDataToImageArray:(NSData *)data;
+ (void)heartbeatView:(UIView *)view duration:(CGFloat)fDuration;

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
+ (void)showAnimationType:(NSString *)type withSubType:(NSString *)subType duration:(CFTimeInterval)duration timingFunction:(NSString *)timingFunction view:(UIView *)theView;
/*
 *  常用的动画效果
 */
//reveal
+ (void)animationRevealFromBottom:(UIView *)view;
+ (void)animationRevealFromTop:(UIView *)view;
+ (void)animationRevealFromLeft:(UIView *)view;
+ (void)animationRevealFromRight:(UIView *)view;
//渐隐渐消
+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;
//翻转
+ (void)animationFlipFromLeft:(UIView *)view;
+ (void)animationFlipFromRight:(UIView *)view;
//翻页
+ (void)animationCurlUp:(UIView *)view;
+ (void)animationCurlDown:(UIView *)view;
//push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;
//move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveLeft:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveRight:(UIView *)view duration:(CFTimeInterval)duration;

/*
 * 旋转缩放
 */
//各种旋转缩放效果
+ (void)animationRotateAndScaleEffects:(UIView *)view;
//旋转提示缩小放大效果
+ (void)animationRotateAndScaleDownUp:(UIView *)view;

#pragma mark --------私有api--------------
/*
 *  下面用到的某些属性在当前api里是不合法的.但也是可以用的
 */
+ (void)animationFlipFromTop:(UIView *)view;
+ (void)animationFlipFromBottom:(UIView *)view;
+ (void)animationCubeFromLeft:(UIView *)view;
+ (void)animationCubeFromRight:(UIView *)view;
+ (void)animationCubeFromTop:(UIView *)view;
+ (void)animationCubeFromBottom:(UIView *)view;
+ (void)animationSuckEffect:(UIView *)view;
+ (void)animationRippleEffect:(UIView *)view;
+ (void)animationCameraOpen:(UIView *)view;
+ (void)animationCameraClose:(UIView *)view;

#pragma mark ---------矩阵变换--------------
+ (UIImage *)transformImage:(UIImage *)aImage;


@end
