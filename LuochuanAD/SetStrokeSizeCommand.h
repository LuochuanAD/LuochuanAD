//
//  SetStrokeSizeCommand.h
//  LuochuanAD
//
//  Created by care on 2017/6/13.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "Command.h"

@class SetStrokeSizeCommand;
@protocol SetStrokeSizeCommandDelegate <NSObject>

- (void)command:(SetStrokeSizeCommand *)command didRequestForStrokeSize:(CGFloat *)size;

@end

@interface SetStrokeSizeCommand : Command

@property (nonatomic, assign) id<SetStrokeSizeCommandDelegate> delegate;
- (void)execute;


@end
