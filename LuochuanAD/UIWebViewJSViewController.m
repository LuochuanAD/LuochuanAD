//
//  UIWebViewJSViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/11.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "UIWebViewJSViewController.h"

@interface UIWebViewJSViewController ()

@end

@implementation UIWebViewJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.someString=@"UIWebView是iOS最常用的SDK质疑,他有一个stringByEvaluatingJavaScriptFromString方法可以将JavaScript嵌入页面中,通过这个方法我们可以在iOS与UIWebView中的网页元素交互";
    [self refreshHtml:nil];
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

- (IBAction)refreshHtml:(id)sender {
    [self loadHtml:@"UIWebViewJS"];
}
- (void)loadHtml:(NSString *)name{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:filePath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWeb loadRequest:request];
}

- (IBAction)runJsFounctionAndParameter:(id)sender {
    [self.myWeb stringByEvaluatingJavaScriptFromString:@"showAlert(\"传参\")"];
}

- (IBAction)getElementsByTagNameForInsertHtml:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementsByTagName('p')[0].innerHTML='%@';",self.someString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString];
}

- (IBAction)getElementsByNameForFillInput:(id)sender {
    NSString *tempString=[NSString stringWithFormat:@"document.getElementsByName('wd')[0].value='%@';",self.someString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString];
}

- (IBAction)getElementByIdForInsertHtml:(id)sender {
    NSString *tempString2=[NSString stringWithFormat:@"document.getElementById('idTest').innerHTML='%@';",self.someString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString2];
}

- (IBAction)insertJsAndRun:(id)sender {
    NSString *insertString=[NSString stringWithFormat:@"var script=document.createElement('script');"
                            "script.type='text/javascript';"
                            "script.text=\"function jsFunc(){"
                            "var a=document.getElementsByTagName('body')[0];"
                            "alert('%@');"
                            "}\";"
                            "document.getElementsByTagName('head')[0].appendChild(script);",self.someString];
    NSLog(@" insert string :%@",insertString);
    [self.myWeb stringByEvaluatingJavaScriptFromString:insertString];
    [self.myWeb stringByEvaluatingJavaScriptFromString:@"jsFunc();"];
}

- (IBAction)replacePictureAddress:(id)sender {
    NSString *tempString2=[NSString stringWithFormat:@"document.getElementsByTagName('img')[0].src='%@';",@"light_advice.png"];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString2];
}

- (IBAction)changeLableTypeace:(id)sender {
    NSString *tempString2=[NSString stringWithFormat:@"document.getElementsByTagName('p')[0].style.fontSize='%@';",@"19px"];
    [self.myWeb stringByEvaluatingJavaScriptFromString:tempString2];
}

- (IBAction)submit:(id)sender {
    [self.myWeb stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit(); "];
}

- (IBAction)location:(id)sender {
    [self loadHtml:@"UIWebView_location"];
  
}

- (IBAction)uploadPictures:(id)sender {
    [self loadHtml:@"UIWebViewJS_file"];
}
@end
