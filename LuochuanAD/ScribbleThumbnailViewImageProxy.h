//
//  ScribbleThumbnailViewImageProxy.h
//  LuochuanAD
//
//  Created by care on 2017/6/9.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ScribbleThumbnailView.h"
#import "ScribbleThumbnailView.h"
#import "Command.h"
@interface ScribbleThumbnailViewImageProxy : ScribbleThumbnailView
{
    UIImage *_realImage;
    BOOL _loadingThreadHaslaunched;
}
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic) Scribble *scribble;
@property (nonatomic, retain) Command *touchCommand;

@end
