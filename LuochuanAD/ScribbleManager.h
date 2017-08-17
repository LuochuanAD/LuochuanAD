//
//  ScribbleManager.h
//  LuochuanAD
//
//  Created by care on 2017/6/9.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scribble.h"
#import "ScribbleThumbnailViewImageProxy.h"
@interface ScribbleManager : NSObject
- (void)saveScribble:(Scribble *)scribble thumbnail:(UIImage *)image;
- (NSInteger )numberOfScribbles;
- (Scribble *)scribbleAtIndex:(NSInteger)index;
- (UIView *)scribbleThumbnailViewAtIndex:(NSInteger)index;
@end
