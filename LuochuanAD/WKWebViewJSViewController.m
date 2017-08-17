//
//  WKWebViewJSViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/23.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "WKWebViewJSViewController.h"

@interface WKWebViewJSViewController ()

@end

@implementation WKWebViewJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"WKWebView调用JS";
    self.myWebView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 221) configuration:[[WKWebViewConfiguration alloc] init]];
    self.myWebView.UIDelegate=self;
    [self.view addSubview:self.myWebView];
    self.view.backgroundColor=[UIColor grayColor];
    self.someString=@"iOS 8引入了一个新的框架——WebKit，之后变得好起来了。在WebKit框架中，有WKWebView可以替换UIKit的UIWebView和AppKit的WebView，而且提供了在两个平台可以一致使用的接口。WebKit框架使得开发者可以在原生App中使用Nitro来提高网页的性能和表现，Nitro就是Safari的JavaScript引擎 WKWebView 不支持JavaScriptCore的方式但提供message handler的方式为JavaScript与Native通信";
    [self refreshHtml:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView{
    NSLog(@"%s",__FUNCTION__);
}
//UIWebView 私有方法,分类拦截alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%s",__FUNCTION__);
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"拦截提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)refreshHtml:(id)sender {
    [self loadHtml:@"WKWebViewJS"];
}
- (void)loadHtml:(NSString *)name{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:filePath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];

}
- (IBAction)runJsAndParam:(id)sender {
    [self.myWebView evaluateJavaScript:@"showAlert('hahaha')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
}

- (IBAction)getElementsByTagNameForInnetHtml:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementsByTagName('p')[0].innerHTML ='%@'",self.someString];
    [self.myWebView evaluateJavaScript:tempString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
}

- (IBAction)getElementsByNameForInput:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementsByName('wd')[0].value='%@';",self.someString];
    [self.myWebView evaluateJavaScript:tempString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
}

- (IBAction)getElementsByIdForInnetHtml:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementById('idTest').innerHTML ='%@'",self.someString];
    [self.myWebView evaluateJavaScript:tempString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
}

- (IBAction)innetJsAndRun:(id)sender {
    NSString *insertString=[NSString stringWithFormat:@"var script=document.createElement('script');"
                            "script.type='text/javascript';"
                            "script.text=\"function jsFunc(){"
                            "var a=document.getElementsByTagName('body')[0];"
                            "alert('%@');"
                            "}\";"
                            "document.getElementsByTagName('head')[0].appendChild(script);",self.someString];
    [self.myWebView evaluateJavaScript:insertString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    [self.myWebView evaluateJavaScript:@"jsFunc()" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
    
}

- (IBAction)replacePictureAddress:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementsByTagName('img')[0].src='%@';",@"light_advice.png"];
    [self.myWebView evaluateJavaScript:tempString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
}

- (IBAction)changeLableFont:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementsByTagName('p')[0].style.fontSize='%@';",@"19px"];
    [self.myWebView evaluateJavaScript:tempString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
}

- (IBAction)submit:(id)sender {
    [self.myWebView evaluateJavaScript:@"document.forms[0].submit();" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
}

- (IBAction)getLocation:(id)sender {
    [self loadHtml:@"WKWebView_location"];
}

- (IBAction)upLoadPictures:(id)sender {
    [self loadHtml:@"WKWebViewJS_file"];
}


@end
