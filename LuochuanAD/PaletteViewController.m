//
//  PaletteViewController.m
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "PaletteViewController.h"

@interface PaletteViewController ()

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SetStrokeColorCommand *colorCommand=(SetStrokeColorCommand *)[_redSlider command];
    [colorCommand setRgbValuesProvider:^(CGFloat *red,CGFloat *green,CGFloat *blue){
        *red=[_redSlider value];
        *green=[_greenSlider value];
        *blue=[_blueSlider value];
    
    }];
    [colorCommand setPostColorUpdateProvider:^(UIColor *color){
        [_paletteView setBackgroundColor:color];
    
    }];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    CGFloat redValue=[ud floatForKey:@"red"];
    CGFloat greenValue=[ud floatForKey:@"green"];
    CGFloat blueValue=[ud floatForKey:@"blue"];
    CGFloat sizeValue=[ud floatForKey:@"size"];
    
    _redSlider.value=redValue;
    _greenSlider.value=greenValue;
    _blueSlider.value=blueValue;
    _sizeSlider.value=sizeValue;
    
    UIColor *color=[UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
    [_paletteView setBackgroundColor:color];
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setFloat:[_redSlider value] forKey:@"red"];
    [ud setFloat:[_greenSlider value] forKey:@"green"];
    [ud setFloat:[_blueSlider value] forKey:@"blue"];
    [ud setFloat:[_sizeSlider value] forKey:@"size"];
    [ud synchronize];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)command:(SetStrokeColorCommand *)command didRequestColorComonetsForRed:(CGFloat *)red withGreen:(CGFloat *)green withBlue:(CGFloat *)blue{
    *red=[_redSlider value];
    *green=[_greenSlider value];
    *blue=[_blueSlider value];

}
- (void)command:(SetStrokeColorCommand *)command didFinnishColorUpdateWithColor:(UIColor *)color{
    [_paletteView setBackgroundColor:color];

}
- (void)command:(SetStrokeSizeCommand *)command didRequestForStrokeSize:(CGFloat *)size{
    *size=[_sizeSlider value];
}
- (IBAction)commandSliderValueChanged:(CommandSlider *)slider{
    [[slider command] execute];
}

@end
