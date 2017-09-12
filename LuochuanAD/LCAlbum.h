//
//  LCAlbum.h
//  LuochuanAD
//
//  Created by care on 2017/9/12.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCPhoto;
@interface LCAlbum : NSObject
@property (nonatomic, strong) LCPhoto *converPhoto;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDate *creationTime;
@property (nonatomic, strong) NSArray *photos;
@end
