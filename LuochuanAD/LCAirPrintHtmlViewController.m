//
//  LCAirPrintHtmlViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/18.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCAirPrintHtmlViewController.h"
#import "SLQPreViewController.h"
#import "SLQPDFPreViewController.h"
@interface LCAirPrintHtmlViewController ()

@end

@implementation LCAirPrintHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)printToHtmlDoc:(id)sender {
    SLQPreViewController *vc=[[SLQPreViewController alloc]init];
    vc.view.backgroundColor=[UIColor whiteColor];
    vc.url=@"total.html";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)printToHtmlPDF:(id)sender {
    SLQPDFPreViewController *vc=[[SLQPDFPreViewController alloc]init];
    vc.view.backgroundColor=[UIColor whiteColor];
    vc.url=@"total.html";
    [self.navigationController pushViewController:vc animated:YES];

}
@end
