//
//  OpenScribbleCommand.h
//  LuochuanAD
//
//  Created by care on 2017/6/12.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "Command.h"

#import "ScribbleSource.h"

@interface OpenScribbleCommand : Command

@property (nonatomic, retain) id<ScribbleSources> scribbleSource;
- (id)initWithScribbleSource:(id<ScribbleSources>)aScribbleSource;
- (void)execute;


@end
