//
//  ScribbleThumbnailView.h
//  LuochuanAD
//
//  Created by care on 2017/6/9.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"
#import "ScribbleSource.h"
@interface ScribbleThumbnailView : UIView<ScribbleSources>

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) Scribble *scribble;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *scribblePath;

@end
