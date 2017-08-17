//
//  LCClearCache.h
//  LuochuanAD
//
//  Created by care on 17/3/14.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCClearCache : NSObject
{
    NSFileManager *_manager;
    NSString *_fileName;
    NSString *_fileAbsolutePath;
}
@end
