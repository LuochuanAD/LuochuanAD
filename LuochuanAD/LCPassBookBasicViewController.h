//
//  LCPassBookBasicViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>
@interface LCPassBookBasicViewController : UIViewController<PKAddPassesViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberPassLable;
@property (weak, nonatomic) IBOutlet UILabel *passInLable;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) NSString *passFileName;
@property (strong, nonatomic) NSString *passTypeName;
@property (strong, nonatomic) NSString *passIdentifier;
@property (strong, nonatomic) NSString *passSerialNum;
@property (strong, nonatomic) PKPassLibrary *passLibrary;

- (IBAction)addPassBtnClicked:(id)sender;
- (IBAction)updatePassBtnClicked:(id)sender;
- (IBAction)showPassBtnClicked:(id)sender;
- (IBAction)deletePassBtnClicked:(id)sender;
- (void)refreshPassStatusView;

@end
