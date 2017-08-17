//
//  MarkEnumerator.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "NSMutableArray+Stack.h"
#import "MarkEnumerator+Internal.h"
@interface MarkEnumerator : NSEnumerator
{
    @private
    NSMutableArray *_stack;
    
}
- (NSArray *)allObjects;
- (id)nextObject;
@end
