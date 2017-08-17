//
//  LCFreeDragView.h
//  LuochuanAD
//
//  Created by care on 17/5/4.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DragDirection){
    DragDirectionAny,
    DragDirectionHorizontal=1,
    DragDirectionVertical=2,
};


@interface LCFreeDragView : UIView<UIPageViewControllerDelegate>

//是否可以拖拽
@property (nonatomic, assign) BOOL dragEnable;
//活动范围
@property (nonatomic, assign) CGRect freeRect;
//拖拽的方向
@property (nonatomic, assign) DragDirection draDirection;
//内置imageView
@property (nonatomic, strong) UIImageView *imageView;
//内置button
@property (nonatomic, strong) UIButton *button;
//内容View
@property (nonatomic, strong) UIView *contentViewForDrag;
//点击回调block
@property (nonatomic, copy) void(^ClickDragViewBlock)(LCFreeDragView *dragView);
//开始拖动的回调
@property (nonatomic, copy) void(^beginDragBlock)(LCFreeDragView *dragView);
//拖动中的回调
@property (nonatomic, copy) void(^DuringDragBlock)(LCFreeDragView *dragView);
//拖动结束的回调
@property (nonatomic, copy) void(^EndDragBlock)(LCFreeDragView *dragView);
//是否黏贴在边界
@property (nonatomic, assign) BOOL isKeepBounds;

@end
