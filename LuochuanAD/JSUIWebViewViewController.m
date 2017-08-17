//
//  JSUIWebViewViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/14.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "JSUIWebViewViewController.h"

@interface JSUIWebViewViewController ()<UIWebViewDelegate>

@end

@implementation JSUIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"JS调用UIWebView";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self reloadButtonClicked:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reloadButtonClicked:(id)sender {
    [self loadHTML:@"JSUIWebView"];
    for (UIView *view in self.view.subviews) {
        if (view.tag==11111) {
            [view removeFromSuperview];
        }
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //重定义web的alert方法,捕获webview弹出的原生alert 可以修改标题和内容等
    [webView stringByEvaluatingJavaScriptFromString:@"window.alert=function(message){ window.location=\"myapp:&func=alert&message=\"+message;}"];
}
-  (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString=[[[request URL]absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([requestString hasPrefix:@"myapp:"]) {
        NSLog(@"requestString:%@",requestString);
        //如果是自己定义的协议,再截取协议中的方法和参数,判断无误后后再这里手动调用OC方法
        NSMutableDictionary *param=[self queryStringToDictionary:requestString];
        NSLog(@"get param:%@",[param description]);
        NSString *func=[param objectForKey:@"func"];
        if ([func isEqualToString:@"addSubView"]) {//调用本地函数1
            Class tempClass=NSClassFromString([param objectForKey:@"view"]);
            CGRect frame=CGRectFromString([param objectForKey:@"frame"]);
            if (tempClass&&[tempClass isSubclassOfClass:[UIWebView class]]) {
                UIWebView *tempObj=[[tempClass alloc]initWithFrame:frame];
                tempObj.tag=[[param objectForKey:@"tag"] integerValue];
                NSURL *url=[NSURL URLWithString:[param objectForKey:@"urlstring"]];
                NSURLRequest *request=[NSURLRequest requestWithURL:url];
                [tempObj loadRequest:request];
                [self.myWebView addSubview:tempObj];
            }
        
        }else if ([func isEqualToString:@"alert"]){//调用本地函数2
            [self showMessage:@"来自网页提示" message:[param objectForKey:@"message"]];
        
        }else if ([func isEqualToString:@"callFunc"]){//调用本地函数3
            NSLog(@"本地函数3:%@,%@,%@",[param objectForKey:@"first"],[param objectForKey:@"second"],[param objectForKey:@"third"]);
        }else if([func isEqualToString:@"testFunc"]){//调用本地函数4
            NSLog(@"本地函数4:%@,%@,%@",[param objectForKey:@"param1"],[param objectForKey:@"param2"],[param objectForKey:@"param3"]);
        
        }
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadHTML:(NSString *)name{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:filePath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}
//get参数转字典
- (NSMutableDictionary *)queryStringToDictionary:(NSString *)string{
    NSMutableArray *elements=(NSMutableArray *)[string componentsSeparatedByString:@"&"];
    [elements removeObjectAtIndex:0];
    NSMutableDictionary *retval=[NSMutableDictionary dictionaryWithCapacity:[elements count]];
    for (NSString *e in elements) {
        NSArray *pair=[e componentsSeparatedByString:@"="];
        [retval setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
    }
    return retval;
}
- (void)showMessage:(NSString *)title message:(NSString *)message{
    if (message ==nil) {
        return;
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
