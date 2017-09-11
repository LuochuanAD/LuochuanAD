//
//  HPUpdaterService.h
//  LuochuanAD
//
//  Created by care on 2017/9/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPUser.h"
@interface HPUpdaterService : NSObject
- (void)updateUser:(HPUser *)user properties:(NSDictionary *)properties;
@end
