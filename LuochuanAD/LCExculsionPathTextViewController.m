//
//  LCExculsionPathTextViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/26.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCExculsionPathTextViewController.h"

@interface LCExculsionPathTextViewController ()

@end

@implementation LCExculsionPathTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBezierPath *circle=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image=[UIImage imageNamed:@"dribbble256_imageio"];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [self.textView addSubview:imageView];
    self.textView.textContainer.exclusionPaths=@[circle];
    
   
    //在设置-通用-辅助功能-更大字体
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(preferredSizeDidChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    
}
- (void)preferredSizeDidChanged:(NSNotification *)n{
    self.textView.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
