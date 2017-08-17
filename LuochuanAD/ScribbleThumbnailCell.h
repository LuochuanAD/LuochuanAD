//
//  ScribbleThumbnailCell.h
//  LuochuanAD
//
//  Created by care on 2017/6/13.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScribbleThumbnailView.h"
@interface ScribbleThumbnailCell : UITableViewCell
+ (NSInteger)numberOfPalaceholders;
- (void)addThumbnailView:(UIView *)thumbnailView atIndex:(NSInteger)index;
@end
