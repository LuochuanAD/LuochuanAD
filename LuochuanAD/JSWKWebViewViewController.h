//
//  JSWKWebViewViewController.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/24.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface JSWKWebViewViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *myWebView;
- (IBAction)reloadHtml:(id)sender;

@end
