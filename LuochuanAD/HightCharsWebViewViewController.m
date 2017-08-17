//
//  HightCharsWebViewViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/5/10.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "HightCharsWebViewViewController.h"

@interface HightCharsWebViewViewController ()

@end

@implementation HightCharsWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"HightchartsView.html"];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    
}
#pragma mark --UIWebViewdelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //禁止选中
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    //禁止长安弹出actionsheet
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    
    self.context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception=exception;
        NSLog(@"%@",exception);
    };
    [self loadCharsData];

}
- (void)loadCharsData{
    NSArray *the1024Data=@[@33,@41,@32,@51,@42,@103,@136];
    NSDictionary *the1024Dict=@{@"name":@"1024",@"data":the1024Data};
    NSArray *theCCAVData=@[@8,@11,@21,@13,@20,@52,@43];
    NSDictionary *theCCAVDict=@{@"name":@"CCAV",@"data":theCCAVData};
    NSArray *seriesArray=@[the1024Dict,theCCAVDict];
    [self.context[@"drawChart"] callWithArguments:@[seriesArray]];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
