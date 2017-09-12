//
//  LCPhoto.h
//  LuochuanAD
//
//  Created by care on 2017/9/12.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCAlbum;
@interface LCPhoto : NSObject

@property (nonatomic, strong) LCAlbum *album;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSArray *comments;
@end
