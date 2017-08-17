//
//  PaletteViewController.h
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandBarButton.h"
#import "CommandSlider.h"
#import "SetStrokeSizeCommand.h"
#import "SetStrokeColorCommand.h"
@interface PaletteViewController : UIViewController<SetStrokeSizeCommandDelegate,SetStrokeColorCommandDelegate>
@property (nonatomic, weak) IBOutlet CommandSlider *redSlider;
@property (nonatomic, weak) IBOutlet CommandSlider *greenSlider;
@property (nonatomic, weak) IBOutlet CommandSlider *blueSlider;
@property (nonatomic, weak) IBOutlet CommandSlider *sizeSlider;
@property (weak, nonatomic) IBOutlet UIView *paletteView;


- (IBAction)commandSliderValueChanged:(CommandSlider *)slider;
@end
