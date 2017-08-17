//
//  UIWebView+JavaScriptAlert.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/23.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScriptAlert)<UIAlertViewDelegate>

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
@end
