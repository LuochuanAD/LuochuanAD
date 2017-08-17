//
//  ScribbleManager.m
//  LuochuanAD
//
//  Created by care on 2017/6/9.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ScribbleManager.h"

#import "OpenScribbleCommand.h"
#define kScribbleDataPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"]
#define kScribbleThumbnailPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/thumbnails"]
@interface ScribbleManager()

- (NSString *)scribbleDtaPath;
- (NSString *)scribbleThumbnailPath;
- (NSArray *)scribbleDatapaths;
- (NSArray *)scribbleThumbnailPaths;

@end


@implementation ScribbleManager



- (void)saveScribble:(Scribble *)scribble thumbnail:(UIImage *)image{
    NSInteger newIndex=[self numberOfScribbles]+1;
    NSString *scribbledataName=[NSString stringWithFormat:@"data_%ld",(long)newIndex];
    NSString *scribbleThumbnailName=[NSString stringWithFormat:@"thumbnail_%ld.png",(long)newIndex];
    ScribbleMemento *scribbleMemento = [scribble scribbleMemento];
    NSData *mementoData = [scribbleMemento data];
    NSString *mementoPath = [[self scribbleDtaPath]
                             stringByAppendingPathComponent:scribbledataName];
    [mementoData writeToFile:mementoPath atomically:YES];
    
    // save the thumbnail directly in
    // the file system
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    NSString *imagePath = [[self scribbleThumbnailPath]
                           stringByAppendingPathComponent:scribbleThumbnailName];
    [imageData writeToFile:imagePath atomically:YES];


}
- (NSInteger )numberOfScribbles{

    NSArray *arr=[self scribbleDatapaths];
    return [arr count];
}
- (Scribble *)scribbleAtIndex:(NSInteger)index{
    Scribble *loadedScribble = nil;
    NSArray *scribbleDataPathsArray = [self scribbleDatapaths];
    NSString *scribblePath = [scribbleDataPathsArray objectAtIndex:index];
    if (scribblePath)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *scribbleData = [fileManager contentsAtPath:[kScribbleDataPath
                                                            stringByAppendingPathComponent:
                                                            scribblePath]];
        ScribbleMemento *scribbleMemento = [ScribbleMemento mementoWithData:scribbleData];
        loadedScribble = [Scribble scribbleWithMemento:scribbleMemento];
    }
    
    return loadedScribble;}
- (UIView *)scribbleThumbnailViewAtIndex:(NSInteger)index{
    ScribbleThumbnailViewImageProxy *  loadedScribbleThumbnail = nil;
    NSArray *scribbleThumbnailPathsArray = [self scribbleThumbnailPaths];
    NSArray *scribblePathsArray = [self scribbleDatapaths];
    NSString *scribbleThumbnailPath = [scribbleThumbnailPathsArray objectAtIndex:index];
    NSString *scribblePath = [scribblePathsArray objectAtIndex:index];
    
    if (scribbleThumbnailPath)
    {

        loadedScribbleThumbnail = [[ScribbleThumbnailViewImageProxy alloc] init] ;
        
        [loadedScribbleThumbnail setImagePath:[kScribbleThumbnailPath
                                               stringByAppendingPathComponent:
                                               scribbleThumbnailPath]];
        [loadedScribbleThumbnail setScribblePath:[kScribbleDataPath
                                                  stringByAppendingPathComponent:
                                                  scribblePath]];
        OpenScribbleCommand *touchCommand = [[OpenScribbleCommand alloc]
                                             initWithScribbleSource:loadedScribbleThumbnail];
        
        [loadedScribbleThumbnail setTouchCommand:touchCommand];
    }
    
    return loadedScribbleThumbnail;
}
- (NSString *)scribbleDtaPath
{
    // lazy create the scribble data directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:kScribbleDataPath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:kScribbleDataPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
    
    return kScribbleDataPath;
}


- (NSString *)scribbleThumbnailPath
{
    // lazy create the scribble thumbnail directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:kScribbleThumbnailPath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:kScribbleThumbnailPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
    
    return kScribbleThumbnailPath;
}


- (NSArray *)scribbleDatapaths
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *scribbleDataPathsArray = [fileManager contentsOfDirectoryAtPath:[self scribbleDtaPath]
                                                                       error:&error];
    
    return scribbleDataPathsArray;
}


- (NSArray*)scribbleThumbnailPaths
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *scribbleThumbnailPathsArray = [fileManager contentsOfDirectoryAtPath:[self scribbleThumbnailPath]
                                                                            error:&error];
    return scribbleThumbnailPathsArray;
}



@end
