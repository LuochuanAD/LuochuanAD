//
//  UIWebView+JavaScriptAlert.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/23.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"
static BOOL alertStatues =NO;
@implementation UIWebView (JavaScriptAlert)
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];

}
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alert show];
    while (alert.hidden==NO&&alert.superview!=nil) {
        [[NSRunLoop mainRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    return alertStatues;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        alertStatues=YES;
    }else if (buttonIndex==1){
        alertStatues=NO;
    
    }
}
@end
