//
//  OcCallJSViewController.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/5/10.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface OcCallJSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
- (IBAction)factorialClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultNumber;
@property (nonatomic, strong) JSContext *context;
@end
