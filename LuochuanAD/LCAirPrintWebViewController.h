//
//  LCAirPrintWebViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCAirPrintWebViewController : UIViewController<UIWebViewDelegate, UIPrintInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *insertTextFiled;
- (IBAction)go:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *insertWebView;

@end
