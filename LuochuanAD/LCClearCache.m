//
//  LCClearCache.m
//  LuochuanAD
//
//  Created by care on 17/3/14.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCClearCache.h"
#import "SDImageCache.h"
@implementation LCClearCache
- (CGFloat)caculatorSize{
    NSString *cacheFilePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSFileManager *manager=[NSFileManager defaultManager];
    _manager=manager;
    if (![_manager fileExistsAtPath:cacheFilePath]) {
        NSLog(@"NULL");
    }
    NSEnumerator *childFilesEnumerator=[[_manager subpathsAtPath:cacheFilePath] objectEnumerator];
    NSString *fileName;
    _fileName=fileName;
    long long folderSize=0;
    while ((_fileName=[childFilesEnumerator nextObject])!=nil) {
        NSString *fileAbsolutePath=[cacheFilePath stringByAppendingPathComponent:_fileName];
        _fileAbsolutePath=fileAbsolutePath;
        folderSize +=[[_manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
    }
    CGFloat intg=[[SDImageCache sharedImageCache]getSize];
    CGFloat sum=folderSize + intg;
    NSLog(@"文件大小%lf",sum);
    return sum;
}
- (void)clearTheCacheForWebView{
    NSString *cacheFilePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSEnumerator *childFilesEnumerator=[[_manager subpathsAtPath:cacheFilePath] objectEnumerator];
    NSString *fileOne;
    while ((fileOne =[childFilesEnumerator nextObject])!=nil) {
        NSString *fileAbsolutePath=[cacheFilePath stringByAppendingPathComponent:fileOne];
        //文件过滤规则
        if ([fileAbsolutePath rangeOfString:@"Jpush"].location != NSNotFound ||[fileAbsolutePath rangeOfString:@"JPUSH"].location!=NSNotFound) {
            
        }else{
            [_manager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
}
@end
