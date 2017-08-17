//
//  CoordinatingController.m
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "CoordinatingController.h"
static CoordinatingController *sharedCoordinator=nil;
@implementation CoordinatingController
- (void)initialize{
    _canvasViewController=[[CanvasViewController alloc]init];
    _activeViewController=_canvasViewController;
    
}

+ (CoordinatingController *)sharedinstance{
    if (sharedCoordinator==nil) {
        sharedCoordinator=[[super alloc] init];
        [sharedCoordinator initialize];
    }
    return sharedCoordinator;
}
- (IBAction)viewChangeByObject:(id)sender{
    NSLog(@"------------------%ld",(long)[(UIBarButtonItem *)sender tag]);
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        switch ([(UIBarButtonItem *)sender tag]) {
            
            case LCButtonClickedOpenPalette:
            {
                PaletteViewController *palette=[[PaletteViewController alloc]init];
                [_canvasViewController presentViewController:palette animated:YES completion:nil];
                _activeViewController=palette;
            }
                break;
            case LCButtonClickedOpenThumbnail:
            {
                ThumbnailViewController *thumbnail=[[ThumbnailViewController alloc]init];
                [_canvasViewController presentViewController:thumbnail animated:YES completion:nil];
                _activeViewController=thumbnail;
            }
                break;
            default:
            {
                [_canvasViewController dismissViewControllerAnimated:YES completion:nil];
                _activeViewController=_canvasViewController;
            }
                break;
        }
    }else{
        [_canvasViewController dismissViewControllerAnimated:YES completion:nil];
        _activeViewController=_canvasViewController;
    
    }


}

@end
