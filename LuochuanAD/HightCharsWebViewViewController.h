//
//  HightCharsWebViewViewController.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/5/10.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface HightCharsWebViewViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) JSContext *context;
@end
