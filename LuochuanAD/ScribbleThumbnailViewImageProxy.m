//
//  ScribbleThumbnailViewImageProxy.m
//  LuochuanAD
//
//  Created by care on 2017/6/9.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ScribbleThumbnailViewImageProxy.h"

@interface ScribbleThumbnailViewImageProxy()
- (void)forwardImageLoadingThread;
@end


@implementation ScribbleThumbnailViewImageProxy



- (Scribble *)scribble{
    if (self.scribble==nil) {
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSData *scribbleData=[fileManager contentsAtPath:self.scribblePath];
        ScribbleMemento *scribbleMemento=[ScribbleMemento mementoWithData:scribbleData];
        self.scribble=[Scribble scribbleWithMemento:scribbleMemento];
        
    }
    return self.scribble;
}
- (UIImage *)image{
    if (_realImage==nil) {
        _realImage=[[UIImage alloc]initWithContentsOfFile:self.imagePath];
    }
    return _realImage;
}
- (void)drawRect:(CGRect)rect{
    if (_realImage==nil) {
        CGContextRef context=UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 10.0);
        const CGFloat dashLengths[2]={10,3};
        CGContextSetLineDash(context, 3, dashLengths, 2);
        CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
        CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
        CGContextAddRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        if (!_loadingThreadHaslaunched) {
            [self performSelectorInBackground:@selector(forwardImageLoadingThread) withObject:nil];
            _loadingThreadHaslaunched=YES;
        }
        
    }else{
        [_realImage drawInRect:rect];
    
    }
 


}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_touchCommand execute];

}
- (void)forwardImageLoadingThread{
    [self image];
    [self performSelectorInBackground:@selector(setNeedsDisplay) withObject:nil];

}
@end
