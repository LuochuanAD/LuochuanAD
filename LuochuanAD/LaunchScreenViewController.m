//
//  LaunchScreenViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LaunchScreenViewController.h"
static NSUInteger kAnimationDurtion=2.8f;
@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self createFirstAnimationView];
    [self createSecondAnimationView];
}
- (void)createFirstAnimationView{
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lcwelcom@2x"]];
    imageview.backgroundColor=[UIColor whiteColor];
    imageview.frame=CGRectMake(0 , 0, WINDOWS.width, WINDOWS.height);
    [self.view addSubview:imageview];
    
    UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flightAnimation@2x"]];
    imgV.frame=CGRectMake(WINDOWS.width/2-50, WINDOWS.height/2-5, 100, 100);
    imgV.alpha=1;
    
    [self.view addSubview:imgV];
    
    [UIView animateWithDuration:kAnimationDurtion delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        imgV.frame=CGRectMake(WINDOWS.width/2-350, -500, 700, 700);
    } completion:^(BOOL finished) {
        [self endScroll];
    }];
    

}
- (void)createSecondAnimationView{
    UIImageView *imageview=[[UIImageView alloc]init];
    imageview.backgroundColor=RGBA(29, 143, 239, 1);
    imageview.frame=CGRectMake(0 , 0, WINDOWS.width, WINDOWS.height);
    [self.view addSubview:imageview];
    UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flightAnimation1"]];
    imgV.frame=CGRectMake(WINDOWS.width/2-50, WINDOWS.height/2-50, 100, 100);
    imgV.alpha=1;
    [self.view addSubview:imgV];
    //先缩小,后放大
    [UIView animateWithDuration:0.6 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
      imgV.transform=CGAffineTransformScale(imgV.transform, 0.7, 0.7);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
           imgV.transform=CGAffineTransformScale(imgV.transform, 12.0, 12.0);
        } completion:^(BOOL finished) {
            [self endScroll];
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewScrollDidEnd:(endScrollBlock)block;{
    self.endBlock=block;
}
- (void)endScroll{
    if (self.endBlock) {
        _endBlock();
    }
}
@end
