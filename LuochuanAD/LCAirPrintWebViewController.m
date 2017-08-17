//
//  LCAirPrintWebViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCAirPrintWebViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LCAirPrintWebViewController ()
{
    NSString *urlString;
}
@end

@implementation LCAirPrintWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"完成PDF" style:UIBarButtonItemStyleDone target:self action:@selector(printWebView)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
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

- (IBAction)go:(id)sender {
    urlString=self.insertTextFiled.text;
    if ([[urlString lowercaseString] hasPrefix:@"http://"]) {
        urlString=[@"http://" stringByAppendingString:urlString];
    }
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    [self.insertWebView loadRequest:request];
    [self.insertTextFiled resignFirstResponder];
    
}
/**
 uiviewprintformatter自动列出多个页面的视图内容。要获取视图的打印格式化程序，请调用view的viewPrintFormatter方法。并不是所有的内置UIKit类都支持打印。目前，只有视图类UIWebView、UITextView和MKMapView知道如何绘制它们的内容。视图格式化程序不应该用于打印您自己的自定义视图。要打印自定义视图的内容，可以使用UIPrintPageRenderer。
 uisimpletextprintformat—自动绘制和列出纯文本文档。这个格式化程序允许您为文本设置全局属性，例如字体、颜色、对齐和换行模式。
 uimarkuptextprintformatter自动绘制和放置HTML文档。
 */

//网页全部
- (void)printWebView{
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u",
                  [error localizedDescription]);
        }
    };
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"html content";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    controller.printInfo = printInfo;
    controller.showsPageRange = YES;
    
    UIViewPrintFormatter *viewFormatter = [self.insertWebView viewPrintFormatter];
    viewFormatter.startPage = 0;
    controller.printFormatter = viewFormatter;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [controller presentFromBarButtonItem:self.navigationItem.leftBarButtonItem animated:YES completionHandler:completionHandler];
    }else
        [controller presentAnimated:YES completionHandler:completionHandler];


}
//网页内容,不包括图片
- (void)printWebViewCode{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"html code";
    pic.printInfo = printInfo;
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"total.html" withExtension:nil];
    NSString *htmlStr=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    UIMarkupTextPrintFormatter *htmlFormatter = [[UIMarkupTextPrintFormatter alloc]
                                                 initWithMarkupText:htmlStr];
    htmlFormatter.startPage = 0;
    htmlFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0); // 1 inch margins
    pic.printFormatter = htmlFormatter;
    pic.showsPageRange = YES;
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            NSLog(@"Printing could not complete because of error: %@", error);
        }
    };
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [pic presentFromBarButtonItem:self.navigationItem.leftBarButtonItem animated:YES completionHandler:completionHandler];
    } else {
        [pic presentAnimated:YES completionHandler:completionHandler];
    }





}
//PDF图片
- (void)printPDF
{
    UIPrintInteractionController *print = [UIPrintInteractionController sharedPrintController];
    print.delegate = self;
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"Print for iOS";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    print.printInfo = printInfo;
    print.showsPageRange = YES;
    
    UIGraphicsBeginImageContext(self.insertWebView.bounds.size);
    [self.insertWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    print.printingItem = image;
    
    void (^completionHandler)(UIPrintInteractionController *,BOOL, NSError *) = ^(UIPrintInteractionController *print,BOOL completed, NSError *error)
    {
        if (!completed && error)
        {
            NSLog(@"Error!");
        }
    };
    
    [print presentAnimated:YES completionHandler:completionHandler];
}
#pragma mark - UIPrintInteractionControllerDelegate

- (void)printInteractionControllerWillPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Will Present");
}

- (void)printInteractionControllerDidPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Did Present");
}

- (void)printInteractionControllerWillDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Will Dismiss");
}

- (void)printInteractionControllerDidDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Did Dismiss");
}

- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Will Start Job");
}

- (void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Did Finish Job");
}

@end
