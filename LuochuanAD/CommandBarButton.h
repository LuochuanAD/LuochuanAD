//
//  CommandBarButton.h
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Command.h"
@interface CommandBarButton : UIBarButtonItem
@property (nonatomic) IBOutlet Command *lcCommand;
@end
