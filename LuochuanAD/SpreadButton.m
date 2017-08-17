//
//  SpreadButton.m
//  SpreadButton
//
//  Created by Mac on 16/4/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SpreadButton.h"


//修改button之间的间隔
#define INTERVAL  5


@interface SpreadButton (){
    NSMutableArray      *_buttonArray;
}
@property (nonatomic,assign)NSInteger buttonCount;
@property (nonatomic,assign)id<SpreadButtonDelegate> delegate;
@end



@implementation SpreadButton

- (instancetype)initWithTitleArray:(NSArray*)titleArray delegate:(id<SpreadButtonDelegate>)delegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.buttonCount = titleArray.count;
        self.delegate = delegate;
        self.titleArray = titleArray;
        [self loadSubview];
        
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//创建子button
- (void)loadSubview{
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:_buttonCount];
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectZero;
        button.tag = i;
        
        [button addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [_buttonArray addObject:button];
    }
}



- (void)buttonClick{
    //初始化子button的位置。
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *but = [_buttonArray objectAtIndex:i];
        [self.superview addSubview:but];
        but.hidden = NO;
        but.frame = self.frame;
    }
    //开始展开动画
    [UIView animateWithDuration:0.5 animations:^{
        for (int i = 0; i<_buttonCount; i++) {
            UIButton *but = [_buttonArray objectAtIndex:i];
            
            [but setTitle:_titleArray[i] forState:UIControlStateNormal];
            //--------------- 可修改button字体颜色 ---------------
            //[but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            
            if (self.directionType == HorizontalDirection) {
                but.frame = CGRectMake(self.frame.origin.x+i*(INTERVAL+self.frame.size.width), self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            }else{
                but.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+i*(INTERVAL+self.frame.size.height), self.frame.size.width, self.frame.size.height);
            }
            
        }
    }];
    
}

- (void)subButtonClick:(UIButton *)sender{
    //收起动画
    [UIView animateWithDuration:0.5 animations:^{
        for (int i = 0; i<_buttonCount; i++) {
            UIButton *but = [_buttonArray objectAtIndex:i];
            but.frame = self.frame;
        }
    } completion:^(BOOL finished) {
        for (int i = 0; i<_buttonCount; i++) {
            UIButton *but = [_buttonArray objectAtIndex:i];
            but.hidden = YES;
            [but removeFromSuperview];
        }
    }];
    
    //调用delegate方法
    [_delegate spreadButton:self clickButtonAtIndex:(int)sender.tag];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIButton *but in _buttonArray) {
        but.backgroundColor = backgroundColor;
    }
}

@end
