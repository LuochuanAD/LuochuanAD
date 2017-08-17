//
//  UIWebViewJSViewController.h
//  TestJsAndWebView
//
//  Created by 罗川 on 2017/3/11.
//  Copyright © 2017年 罗川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewJSViewController : UIViewController

@property (nonatomic, strong) NSString *someString;
@property (weak, nonatomic) IBOutlet UIWebView *myWeb;
- (IBAction)refreshHtml:(id)sender;
- (IBAction)runJsFounctionAndParameter:(id)sender;
- (IBAction)getElementsByTagNameForInsertHtml:(id)sender;
- (IBAction)getElementsByNameForFillInput:(id)sender;
- (IBAction)getElementByIdForInsertHtml:(id)sender;
- (IBAction)insertJsAndRun:(id)sender;
- (IBAction)replacePictureAddress:(id)sender;
- (IBAction)changeLableTypeace:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)location:(id)sender;
- (IBAction)uploadPictures:(id)sender;

@end
