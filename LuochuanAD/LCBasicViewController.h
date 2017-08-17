//
//  LCBasicViewController.h
//  LuochuanAD
//
//  Created by care on 17/2/23.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    PushDefaults,
    PushOther =1
}PushAnimationType;
typedef enum{
    PopDefaults,
    PopOther =1
}PopAnimationType;

@protocol lcbuttonDelegate <NSObject>
@optional
- (void)leftOneButtonClicked:(UIButton *)leftOneBtn;
- (void)leftTwoButtonClicked:(UIButton *)leftTwoBtn;

- (void)rightOneButtonClicked:(UIButton *)rightOneBtn;
- (void)rightTwoButtonClicked:(UIButton *)rightTwoBtn;

@end

@interface LCBasicViewController : UIViewController
@property (nonatomic, weak)NSObject<lcbuttonDelegate> *delegate;


- (void)lcpushViewController:(UIViewController *)pushVC withAnimationType:(PushAnimationType)pushAnimationType ;
- (void)lcpopViewController:(UIViewController *)popVC withAnimationType:(PopAnimationType)popAnimationType;
@end
