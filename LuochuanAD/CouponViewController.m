//
//  CouponViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "CouponViewController.h"
#import <PassKit/PassKit.h>
@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passFileName=@"Coupon";
    self.passTypeName=@"Coupon";
    self.passIdentifier=@"pass.explore-systems.icfpasstest.coupon";
    self.passSerialNum=@"12345";
    // Do any additional setup after loading the view.
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

@end
