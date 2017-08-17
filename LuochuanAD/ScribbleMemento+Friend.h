//
//  ScribbleMemento+Friend.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ScribbleMemento.h"
#import "Mark.h"
#import "ScribbleMemento.h"
@interface ScribbleMemento (Friend)
- (id)initWithMark:(id<Mark>)aMark;
@property (nonatomic,copy) id<Mark>mark;
@property (nonatomic, assign) BOOL hasCompleteSnapshot;
@end
