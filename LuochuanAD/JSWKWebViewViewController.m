//
//  JSWKWebViewViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/24.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "JSWKWebViewViewController.h"

@interface JSWKWebViewViewController ()

@end

@implementation JSWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"JS调用WKWebView";
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    config.userContentController=[[WKUserContentController alloc]init];
    [config.userContentController addScriptMessageHandler:self name:@"Native"];
    self.myWebView=[[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    self.myWebView.UIDelegate=self;
    [self.view addSubview:self.myWebView];
    [self reloadHtml:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView{
    NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%s",__FUNCTION__);
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
#pragma mark --WKScriptMessageHandle
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"Native"]) {
        NSMutableDictionary *param=[self queryStringToDictionary:message.body];
        NSLog(@"%@",[param description]);
        NSString *func=[param objectForKey:@"func"];
        if ([func isEqualToString:@"alert"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"来自网页的提示" message:[param objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        if ([func isEqualToString:@"addSubView"]) {
            if ([[param objectForKey:@"view"] isEqualToString:@"UIWebView"]) {
                
                NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[param objectForKey:@"urlstring"]]];
                [self.myWebView loadRequest:request];
                
            }
        }
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSMutableDictionary *)queryStringToDictionary:(NSString *)string{
    NSMutableArray *elements=(NSMutableArray *)[string componentsSeparatedByString:@"&"];
    NSMutableDictionary *retval=[NSMutableDictionary dictionaryWithCapacity:[elements count]];
    for (NSString *e in elements) {
        NSArray *pair=[e componentsSeparatedByString:@"="];
        [retval setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
    }
    return retval;
}
- (IBAction)reloadHtml:(id)sender {
    [self loadHTML:@"JSWKWebView"];

}
- (void)loadHTML:(NSString *)name{
    NSString *fiilePath=[[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:fiilePath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];

}
@end
