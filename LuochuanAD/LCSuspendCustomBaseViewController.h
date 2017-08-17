//
//  LCSuspendCustomBaseViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SuspendType){
    BUTTON    =0,
    IMAGEVIEW =1,
    GIF       =2,
    MUSIC     =3,
    VIDEO     =4,
    SCROLLVIEW =5,
    OTHERVIEW =6
};
@interface LCSuspendCustomBaseViewController : UIViewController
@property (nonatomic, assign) SuspendType suspendType;

@end
