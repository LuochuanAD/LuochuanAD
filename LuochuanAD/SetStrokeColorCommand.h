//
//  SetStrokeColorCommand.h
//  LuochuanAD
//
//  Created by care on 2017/6/13.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "Command.h"

typedef void(^RGBValuesProvider)(CGFloat *red,CGFloat *green,CGFloat *blue);

typedef void(^PostColorUpdateProvider)(UIColor *color);
@class SetStrokeColorCommand;

@protocol SetStrokeColorCommandDelegate <NSObject>

- (void)command:(SetStrokeColorCommand *)command didRequestColorComonetsForRed:(CGFloat *)red withGreen:(CGFloat *)green withBlue:(CGFloat *)blue;
- (void)command:(SetStrokeColorCommand *)command didFinnishColorUpdateWithColor:(UIColor *)color;

@end

@interface SetStrokeColorCommand : Command

@property (nonatomic, assign) id<SetStrokeColorCommandDelegate> delegate;
@property (nonatomic, copy) RGBValuesProvider rgbValuesProvider;
@property (nonatomic, copy) PostColorUpdateProvider postColorUpdateProvider;
- (void)execute;


@end
