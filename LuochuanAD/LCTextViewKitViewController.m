//
//  LCTextViewKitViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/25.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCTextViewKitViewController.h"

@interface LCTextViewKitViewController ()
{
    NSURL *openURL;
}
@end

@implementation LCTextViewKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     UIDataDetectorTypePhoneNumber                                        = 1 << 0, // Phone number detection
     UIDataDetectorTypeLink                                               = 1 << 1, // URL detection
     UIDataDetectorTypeAddress NS_ENUM_AVAILABLE_IOS(4_0)                 = 1 << 2, // Street address detection
     UIDataDetectorTypeCalendarEvent NS_ENUM_AVAILABLE_IOS(4_0)           = 1 << 3, // Event detection
          */
    [self.textView setDataDetectorTypes:UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink|UIDataDetectorTypeAddress|UIDataDetectorTypeCalendarEvent];
    self.textView.text=@"Github:https://github.com/LuochuanAD  iPhone:18551685873 Address:nanjing Time: 2017/05/25 16:32";//
    
    self.textView.editable=NO;
    
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    openURL=URL;
    if([[URL absoluteString]hasPrefix:@"http://"]|[[URL absoluteString]hasPrefix:@"https://"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"url" message:[URL absoluteString] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"go", nil];
        [alert show];
        return NO;
    }
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        return;
    }else{
        [[UIApplication sharedApplication]openURL:openURL];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
