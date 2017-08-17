//
//  GenericViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "GenericViewController.h"
#import <PassKit/PassKit.h>
@interface GenericViewController ()

@end

@implementation GenericViewController

- (void)viewDidLoad {
    
    self.passFileName=@"Generic";
    self.passTypeName=@"Generic Pass";
    self.passIdentifier=@"pass.explore-systems.icfpasstest.generic";
    self.passSerialNum=@"12345";
    [super viewDidLoad];
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
