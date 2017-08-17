//
//  WKWebViewJSViewController.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/23.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WKWebViewJSViewController : UIViewController<WKUIDelegate>
@property (nonatomic, strong) WKWebView *myWebView;
@property (nonatomic, strong) NSString *someString;

- (IBAction)refreshHtml:(id)sender;

- (IBAction)runJsAndParam:(id)sender;
- (IBAction)getElementsByTagNameForInnetHtml:(id)sender;

- (IBAction)getElementsByNameForInput:(id)sender;
- (IBAction)getElementsByIdForInnetHtml:(id)sender;
- (IBAction)innetJsAndRun:(id)sender;
- (IBAction)replacePictureAddress:(id)sender;

- (IBAction)changeLableFont:(id)sender;
- (IBAction)submit:(id)sender;

- (IBAction)getLocation:(id)sender;

- (IBAction)upLoadPictures:(id)sender;



@end
