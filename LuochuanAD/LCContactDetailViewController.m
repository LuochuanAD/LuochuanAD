//
//  LCContactDetailViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCContactDetailViewController.h"

@interface LCContactDetailViewController ()

@end

@implementation LCContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"联系人信息";
    // Do any additional setup after loading the view from its nib.
    self.firstName.text=self.model.firstName;
    self.lastName.text=self.model.lastName;
    self.iconImage.image=[UIImage imageWithData:self.model.iconImage];
    self.phoneNumber.text=self.model.personPhone;
    self.address.text=self.model.address;
    self.company.text=self.model.company;
    self.email.text=self.model.email;
    self.job.text=self.model.job;
    
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
