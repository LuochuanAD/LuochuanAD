//
//  NSMutableArray+Stack.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)
- (void)push:(id)object;
- (id)pop;
- (void)dropBottom;
@end
