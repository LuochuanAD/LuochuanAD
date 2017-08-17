//
//  JSCallOCViewController.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/4/23.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSExport <JSExport>

JSExportAs(calculateForJS,
- (void)handleFactorialCalculateWithnumber:(NSString *)number
           );
- (void)pushViewController:(NSString *)view title:(NSString *)title;

@end

@interface JSCallOCViewController : UIViewController<UIWebViewDelegate,TestJSExport>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) JSContext * context;
@end
