//
//  BoardingPassViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "BoardingPassViewController.h"
#import <PassKit/PassKit.h>
@interface BoardingPassViewController ()

@end

@implementation BoardingPassViewController

- (void)viewDidLoad {
    
    self.passFileName=@"BoardingPass";
    self.passTypeName=@"Boarding Pass";
    self.passIdentifier=@"pass.explore-systems.icfpasstest.boardingpass";
    self.passSerialNum=@"12345";
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
