//
//  LCAddNewContactPersonViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//


#import "JKRBubbleViewController.h"
@interface LCAddNewContactPersonViewController : JKRBubbleViewController


@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UITextField *fiestNameInput;
@property (weak, nonatomic) IBOutlet UITextField *lastNameInput;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberInput;
@property (weak, nonatomic) IBOutlet UITextField *companyInput;
@property (weak, nonatomic) IBOutlet UITextField *jobInput;
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *addressInput;

- (IBAction)tapSelectIconImage:(UITapGestureRecognizer *)sender;

@property (nonatomic,copy,readwrite) void (^myBlock)(UIImage *icon,NSString *firstName,NSString *lastname,NSString *phone,NSString *company,NSString *job,NSString *email,NSString *address);
- (IBAction)cancel:(id)sender;
- (IBAction)add:(id)sender;


@end
