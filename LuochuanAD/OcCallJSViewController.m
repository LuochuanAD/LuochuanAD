//
//  OcCallJSViewController.m
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/5/10.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import "OcCallJSViewController.h"

@interface OcCallJSViewController ()

@end

@implementation OcCallJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.context=[[JSContext alloc]init];
    [self.context evaluateScript:[self loadJSFile:@"theFactorialForNumber"]];
}
- (NSString *)loadJSFile:(NSString *)fileName{
    NSString *path=[[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
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

- (IBAction)factorialClicked:(id)sender {
    NSNumber *inputNumber=[NSNumber numberWithInteger:[self.textFiled.text integerValue]];
    JSValue *function=[self.context objectForKeyedSubscript:@"factorial"];
    JSValue *reult=[function callWithArguments:@[inputNumber]];
    self.resultNumber.text=[NSString stringWithFormat:@"%@",[reult toNumber]];
    
    
}
@end
