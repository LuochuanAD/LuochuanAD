//
//  LCTextViewKitViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/25.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTextViewKitViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
