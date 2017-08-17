//
//  LCBasicViewController.m
//  LuochuanAD
//
//  Created by care on 17/2/23.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCBasicViewController.h"

@interface LCBasicViewController ()
@property (nonatomic, strong)UIButton *leftOneBtn;
@property (nonatomic, strong)UIButton *leftTwoBtn;
@property (nonatomic, strong)UIButton *centerBtn;
@property (nonatomic, strong)UIButton *rightOneBtn;
@property (nonatomic, strong)UIButton *rightTwoBtn;
@end

@implementation LCBasicViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.leftOneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftOneBtn.frame=CGRectMake(0, 20, 40, 40);
    [self.leftOneBtn setBackgroundImage:[UIImage imageNamed:@"Nav_new_rightarrow"] forState:UIControlStateNormal];
    [self.leftOneBtn addTarget:self action:@selector(leftOneBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftOneItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftOneBtn];
    
    self.leftTwoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftTwoBtn.frame=CGRectMake(0, 20, 40, 40);
    [self.leftTwoBtn addTarget:self action:@selector(leftTwoBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftTwoItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftOneBtn];
    
    self.centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtn.frame=CGRectMake(0, 0, 40, 40);
    
    self.rightOneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightOneBtn.frame=CGRectMake(20, 20, 40, 40);
    [self.rightOneBtn addTarget:self action:@selector(rightOneBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightOneItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightOneBtn];
    
    self.rightTwoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightTwoBtn.frame=CGRectMake(80, 20, 40, 40);
    [self.rightTwoBtn addTarget:self action:@selector(rightTwoBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightTwoItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightTwoBtn];
    
    self.navigationItem.leftBarButtonItems=@[leftOneItem,leftTwoItem];
    self.navigationItem.rightBarButtonItems=@[rightOneItem,rightTwoItem];
    self.navigationItem.titleView=self.centerBtn;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationLeftOne:) name:@"changeNavigationLeftOne" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationLeftTwo:) name:@"changeNavigationLeftTwo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationCenter:) name:@"changeNavigationCenter" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationRightOne:) name:@"changeNavigationRightOne" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationRightTwo:) name:@"changeNavigationRightTwo" object:nil];
}
- (void)notificationLeftOne:(NSNotification *)n{
    
}
- (void)notificationLeftTwo:(NSNotification *)n{
    
}

- (void)notificationCenter:(NSNotification *)n{
    
}

- (void)notificationRightOne:(NSNotification *)n{
    
}
- (void)notificationRightTwo:(NSNotification *)n{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftOneBtn:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(leftOneButtonClicked:)]) {
        [_delegate leftOneButtonClicked:btn];
    }
}
- (void)leftTwoBtn:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(leftTwoButtonClicked:)]) {
        [_delegate leftTwoButtonClicked:btn];
    }
}
- (void)rightOneBtn:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(rightOneButtonClicked:)]) {
        [_delegate rightOneButtonClicked:btn];
    }
}
- (void)rightTwoBtn:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(rightTwoButtonClicked:)]) {
        [_delegate rightTwoButtonClicked:btn];
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
- (void)lcpushViewController:(UIViewController *)pushVC withAnimationType:(PushAnimationType)pushAnimationType{
    if (pushAnimationType==PushDefaults) {
        CATransition *animation=[CATransition animation];
        [animation setDuration:0.3];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController pushViewController:pushVC animated:NO];
        [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    }else if (pushAnimationType==PushOther){
    
    }
}
- (void)lcpopViewController:(UIViewController *)popVC withAnimationType:(PopAnimationType)popAnimationType{
    if (popAnimationType==PopDefaults) {
        CATransition *animation=[CATransition animation];
        [animation setDuration:0.3];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
        if (popVC==nil) {
            [self.navigationController popViewControllerAnimated:NO];
        }else{
            [self.navigationController popToViewController:popVC animated:NO];
        }
    }else if (popAnimationType==PopOther){
    
    }
}
@end
