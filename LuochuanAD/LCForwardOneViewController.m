//
//  LCForwardOneViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LCForwardOneViewController.h"
#import "HttpRequest.h"

#import "LCBackGroundtaskViewController.h"
#import "LCKeyChainViewController.h"
@interface LCForwardOneViewController ()<HTTPRequestDelegate>
{
    HttpRequest *testRequest1;
    HttpRequest *testRequest2;

}

@end

@implementation LCForwardOneViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithTitle:@"后台任务" style:UIBarButtonItemStyleDone target:self action:@selector(pushToBackGroungTaskVC)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"KeyChain" style:UIBarButtonItemStylePlain target:self action:@selector(pushToKeyChainVC)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
    
    
}
- (void)testRequest{
    testRequest1=[HttpRequest sharedHttpRequest];
    testRequest1.delegate=self;
    testRequest2=[HttpRequest sharedHttpRequest];
    testRequest2.delegate=self;
    
    dispatch_group_t group;
    dispatch_group_enter(group);
    [testRequest1 startRequestType:GETRequest withParms:nil withPath:@""];
    dispatch_group_enter(group);
    [testRequest2 startRequestType:POSTRequest withParms:@{@"post":@"1"} withPath:nil];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"同时请求,都已完成");
    });
    NSURL *url=[NSURL URLWithString:@"http://www.onevcat.com/2011/11/debug/;param?p=307#more-307"];
    NSLog(@"Scheme:%@",[url scheme]);
    NSLog(@"Host:%@",[url host]);
    NSLog(@"Port:%@",[url port]);
    NSLog(@"Path:%@",[url path]);
    NSLog(@"Relative Path:%@",[url relativePath]);
    NSLog(@"Path components as array:%@",[url pathComponents]);
    NSLog(@"Query:%@",[url query]);
    NSLog(@"Fragment:%@",[url fragment]);
}
#pragma mark --HTTPRequestDelegate
- (void)requestStarted:(HttpRequest *)request{

}
- (void)request:(HttpRequest *)request didReciveData:(id)data{

}
- (void)requestFailed:(HttpRequest *)request{


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushToBackGroungTaskVC{
    LCBackGroundtaskViewController *bgVC=[[LCBackGroundtaskViewController alloc]init];
    [self.navigationController pushViewController:bgVC animated:YES];
}
- (void)pushToKeyChainVC{
    LCKeyChainViewController *keyChainVC=[[LCKeyChainViewController alloc]init];
    [self.navigationController pushViewController:keyChainVC animated:YES];

}

@end
