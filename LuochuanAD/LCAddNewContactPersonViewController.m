//
//  LCAddNewContactPersonViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCAddNewContactPersonViewController.h"


@interface LCAddNewContactPersonViewController ()

@end

@implementation LCAddNewContactPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}
- (IBAction)add:(id)sender {
    _myBlock(self.iconImage.image,self.fiestNameInput.text,self.lastNameInput.text,self.phoneNumberInput.text,self.companyInput.text,self.jobInput.text,self.emailInput.text,self.addressInput.text);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

- (IBAction)tapSelectIconImage:(UITapGestureRecognizer *)sender {
    
    
    
    
}
- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
