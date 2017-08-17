//
//  LCTabBarViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LCTabBarViewController.h"

@interface LCTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation LCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setup];
}
- (void)setup{
    [self addCenterButtonImage:[UIImage imageNamed:@"focus_iconadd1"] withSelectedImage:[UIImage imageNamed:@"focus_iconadd"]];
    self.delegate=self;
    self.selectedIndex=2;
    _button.selected=YES;
    self.tabBar.tintColor=RGBA(222, 78, 22, 1);
    
}
- (void)addCenterButtonImage:(UIImage *)image withSelectedImage:(UIImage *)selectedImage{
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    [_button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    _button.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    _button.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [_button setImage:image forState:UIControlStateNormal];
    [_button setImage:selectedImage forState:UIControlStateSelected];
    _button.adjustsImageWhenHighlighted=NO;
    
    CGFloat heightDifference=image.size.height-self.tabBar.frame.size.height;
    if (heightDifference<0) {
        _button.center=self.tabBar.center;
    }else{
        CGPoint center=self.tabBar.center;
        center.y=center.y-heightDifference/2.0;
        _button.center=center;
    }
    [self.view addSubview:_button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressChange:(UIButton *)button{
    self.selectedIndex=2;
    button.selected=YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (self.selectedIndex==2) {
        _button.selected=YES;
    }else{
        _button.selected=NO;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
