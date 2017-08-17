//
//  MarkEnumerator+Internal.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "MarkEnumerator.h"

@interface NSEnumerator (Internal)
- initWithMark:(id <Mark>)mark;
- (void) traverseAndBuildStackWithMark:(id <Mark>)mark;
@end
