//
//  SLQPreViewController
//  NanhaiPoliceM
//
//  Created by MrSong on 17/1/16.
//  Copyright © 2017年 slq. All rights reserved.
//  
#pragma mark - 布局
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define NavigationBarHeight 64

#import "SLQPreViewController.h"
#import "SLQPrintPageRenderer.h"
#import <MessageUI/MessageUI.h>
#import <UIKit/UIPrinterPickerController.h>


@interface SLQPreViewController ()<UIWebViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSURLRequest *res;

@property (nonatomic, strong) NSString *pdfFileName;
@end

@implementation SLQPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"预览";
    // A4 595 841
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 0)];
    [self.view addSubview:web];
    _webView = web;
    web.delegate = self;
    web.backgroundColor = [UIColor greenColor];
    web.scalesPageToFit = YES;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
}

- (void)setUrl:(NSString *)str {
   
    NSURL *url=[[NSBundle mainBundle]URLForResource:str withExtension:nil];
    
    NSString *html=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    self.webView.scalesPageToFit=YES;
    
    _url = html;
    [self.webView loadHTMLString:html baseURL:baseUrl];
}

- (void)selectRightAction:(UIBarButtonItem *)btnItem {
    NSLog(@"打印");
    [self printWebPage];
}

#pragma mark - 打印html
// 打印html
- (void)printWebPage
{
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!");
        return;
    }
    
    UIPrintInteractionCompletionHandler completionHandler =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %ld", error.domain, (long)error.code);
        }
    };
    
    
    // 设置打印机的一些默认信息
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    // 输出类型
    printInfo.outputType = UIPrintInfoOutputGeneral;
    // 打印队列名称
    printInfo.jobName = @"HtmlDemo";
    // 是否单双面打印
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    // 设置默认打印信息
    controller.printInfo = printInfo;
    
    // 显示页码范围
    controller.showsPageRange = YES;
    
    // 预览设置
    SLQPrintPageRenderer *myRenderer = [[SLQPrintPageRenderer alloc] init];

    // 生成html格式
    UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
    [myRenderer addPrintFormatter:viewFormatter startingAtPageAtIndex:0];
    // 渲染html
    controller.printPageRenderer = myRenderer;
    
    [controller presentAnimated:YES completionHandler:completionHandler];
}


- (void)exportHtml {
    
}

// 始发送请求（加载数据）时调用这个方法
- (void)webViewDidStartLoad:(UIWebView *)webView {

}
// 请求完毕（加载数据完毕）时调用这个方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
}
// 请求错误时调用这个方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}
// UIWebView在发送请求之前，都会调用这个方法，如果返回NO，代表停止加载请求，返回YES，代表允许加载请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}
#pragma mark - 设置邮件基本信息
// 设置邮件基本信息
-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    //设置主题
    [picker setSubject:@"HTMLDemo"];
    
    //设置收件人
    NSArray *toRecipients = [NSArray arrayWithObjects:@"xxxx@163.com",nil];
    
    [picker setToRecipients:toRecipients];
    
    //设置附件为pdf
    NSData *myData = [NSData dataWithContentsOfFile:self.pdfFileName];
    if (myData) {
        [picker addAttachmentData:myData mimeType:@"application/pdf" fileName:@"HTMLDemo"];
    }
    
    // 设置邮件发送内容
    NSString *emailBody = @"哈哈尽快哈就合法进口分哈萨克黄齑淡饭";
    [picker setMessageBody:emailBody isHTML:NO];
    
    //邮件发送的模态窗口
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - MFMailComposeViewControllerDelegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
