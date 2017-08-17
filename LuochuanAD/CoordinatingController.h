//
//  CoordinatingController.h
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasViewController.h"
#import "PaletteViewController.h"
#import "ThumbnailViewController.h"

typedef NS_ENUM(NSUInteger,LCButtonClicked){
    LCButtonClickedDone =1,
    LCButtonClickedOpenPalette =2,
    LCButtonClickedOpenThumbnail =3

};
@interface CoordinatingController : NSObject

@property (nonatomic, readonly) UIViewController *activeViewController;
@property (nonatomic, readonly) CanvasViewController *canvasViewController;
+ (CoordinatingController *)sharedinstance;

- (IBAction)viewChangeByObject:(id)sender;
@end
