//
//  RootViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/11.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "RootViewController.h"
#import "UIWebViewJSViewController.h"
#import "JSUIWebViewViewController.h"
#import "WKWebViewJSViewController.h"
#import "JSWKWebViewViewController.h"
#import "JSCallOCViewController.h"
#import "OcCallJSViewController.h"
#import "HightCharsWebViewViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"js与webView交互";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)uiwebViewToJavaScriptButtonClicked:(UIButton *)sender {
    UIWebViewJSViewController *webJS=[[UIWebViewJSViewController alloc]initWithNibName:@"UIWebViewJSViewController" bundle:nil];
    [self.navigationController pushViewController:webJS animated:YES];
    
}
- (IBAction)javaScriptToUIWebViewButtonClicked:(UIButton *)sender {
    JSUIWebViewViewController *jsWebVC=[[JSUIWebViewViewController alloc]initWithNibName:@"JSUIWebViewViewController" bundle:nil];
    [self.navigationController pushViewController:jsWebVC animated:YES];
    
}
- (IBAction)wkwebViewToJavaScriptButtonClicked:(UIButton *)sender {
    WKWebViewJSViewController *wkWebVC=[[WKWebViewJSViewController alloc]init];
    [self.navigationController pushViewController:wkWebVC animated:YES];
    
}
- (IBAction)javaScriptToWKWebViewButtonClicked:(id)sender {
    JSWKWebViewViewController *jsWebVC=[[JSWKWebViewViewController alloc]init];
    [self.navigationController pushViewController:jsWebVC animated:YES];
    
}
- (IBAction)jsCoreToObjectiveC:(id)sender {
    JSCallOCViewController *jscallVC=[[JSCallOCViewController alloc]init];
    [self.navigationController pushViewController:jscallVC animated:YES];
}
- (IBAction)objectiveCTojsCore:(id)sender {
    OcCallJSViewController *ocCallJs=[[OcCallJSViewController alloc]init];
    [self.navigationController pushViewController:ocCallJs animated:YES];
    
}
- (IBAction)heightChartsWeb:(id)sender {
    HightCharsWebViewViewController *highCharsVC=[[HightCharsWebViewViewController alloc]init];
    [self.navigationController pushViewController:highCharsVC animated:YES];
}



- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
