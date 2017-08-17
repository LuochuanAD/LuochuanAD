//
//  ThumbnailViewController.h
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScribbleThumbnailCell.h"
#import "ScribbleManager.h"
#import "CommandBarButton.h"
@interface ThumbnailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    ScribbleManager *_scribblemanager;

}
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;


@end
