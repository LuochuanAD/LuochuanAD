//
//  ScribbleMemento.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

@interface ScribbleMemento : NSObject
{
    @private
    id <Mark>_mark;
    BOOL _hasCompleteSnapshot;

}
+ (ScribbleMemento *)mementoWithData:(NSData *)data;
- (NSData *)data;
@end
