//
//  LaunchScreenViewController.h
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^endScrollBlock)();

@interface LaunchScreenViewController : UIViewController

@property (nonatomic, copy)endScrollBlock endBlock;
- (void)viewScrollDidEnd:(endScrollBlock)block;

@end
