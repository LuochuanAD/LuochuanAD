//
//  JSCallOCViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/4/23.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "JSCallOCViewController.h"
#import "SecondViewController.h"
@interface JSCallOCViewController ()

@end

@implementation JSCallOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"js call oc";
    NSString *path=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"JSCallOC.html"];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler=^(JSContext *context,JSValue *exceptionValue){
        context.exception=exceptionValue;
        NSLog(@"%@",exceptionValue);
    };
    self.context[@"app"]=self;
    self.context[@"log"]=^(NSString *str){
        NSLog(@"%@",str);
    };
    self.context[@"alert"]=^(NSString *str){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"msg from js" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    };
    __block typeof(self) weakSelf=self;
    self.context[@"addSubView"]=^(NSString *viewname){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 500, 300, 10)];
        view.backgroundColor=[UIColor redColor];
        UISwitch *sw=[[UISwitch alloc]init];
        [view addSubview:sw];
        [weakSelf.view addSubview:view];
    };
    self.context[@"mutiParams"]=^(NSString * a,NSString *b,NSString *c){
        NSLog(@"%@ %@ %@",a,b,c);
    };
    
}

- (void)handleFactorialCalculateWithnumber:(NSString *)number{
    NSLog(@"%@",number);
    NSNumber *result=[self calculateFactorialOfNumber:@([number integerValue])];
    NSLog(@"%@",result);
    [self.context[@"showResult"] callWithArguments:@[result]];


}

- (void)pushViewController:(NSString *)view title:(NSString *)title{
    Class second=NSClassFromString(view);
    id secondVC=[[second alloc]init];
    ((UIViewController *)secondVC).title=title;
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number{
    NSInteger i=[number integerValue];
    if (i<0) {
        return [NSNumber numberWithInteger:0];
    }
    if (i==0) {
        return [NSNumber numberWithInteger:1];
    }
    NSInteger r=(i*[(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i-1)]] integerValue]);
    return [NSNumber numberWithInteger:r];
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
