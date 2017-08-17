//
//  LCTwitterAndFaceBookSharedViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/18.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface LCTwitterAndFaceBookSharedViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate>
- (IBAction)sharedToFaceBook:(UIButton *)sender;
- (IBAction)sharedToTwitter:(UIButton *)sender;
- (IBAction)selectImage:(UIButton *)sender;
- (IBAction)clearAllImages:(UIButton *)sender;
- (IBAction)addUrl:(UIButton *)sender;
- (IBAction)clearAllUrl:(UIButton *)sender;



@property (weak, nonatomic) IBOutlet UILabel *changeCharlable;
@property (weak, nonatomic) IBOutlet UITextView *changeCharTextView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextFiled;

@property (weak, nonatomic) IBOutlet UITextView *urlTextView;
@property (weak, nonatomic) IBOutlet UIButton *clearAllImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearAllUrlBtn;


@end
