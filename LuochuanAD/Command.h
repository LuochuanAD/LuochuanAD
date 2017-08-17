//
//  Command.h
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject

@property (nonatomic, assign) NSDictionary *userInfo;
- (void)execute;
- (void)undo;

@end
