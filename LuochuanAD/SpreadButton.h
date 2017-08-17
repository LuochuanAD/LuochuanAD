//
//  SpreadButton.h
//  SpreadButton
//
//  Created by Mac on 16/4/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DirectionType) {
    HorizontalDirection = 0,                         // 水平方向
    VerticalDirection,                               // 竖直方向
  
};


@class SpreadButton;

@protocol SpreadButtonDelegate <NSObject>

- (void)spreadButton:(SpreadButton *)button clickButtonAtIndex:(int)index;

@end


@interface SpreadButton : UIButton


//初始化方法，设置button打开后一共显示几个button
- (instancetype)initWithTitleArray:(NSArray*)titleArray delegate:(id<SpreadButtonDelegate>)delegate;

@property (nonatomic, assign) DirectionType directionType;


@property (nonatomic, retain) NSArray *titleArray;

@end
