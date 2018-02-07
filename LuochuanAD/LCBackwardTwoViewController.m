//
//  LCBackwardTwoViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LCBackwardTwoViewController.h"
#import "LCFreeDragView.h"
#import "UIImageView+WebCache.h"
#import "LCHealthKitViewController.h"

#import "TableViewController.h"
#import "RootViewController.h"

#import "RKSwipeBetweenViewControllers.h"
#import "LCUIWebViewViewController.h"
#import "LCCoreAnimationViewController.h"
#import "CoordinatingController.h"

#import "LCLayerViewController.h"
@interface LCBackwardTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_mutArray;
}
@end

@implementation LCBackwardTwoViewController
- (void)dealloc
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mutArray=@[@"机位Html",@"OC与JS交互",@"涂鸦",@"核心动画",@"动画"];
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc]initWithTitle:@"AirPrint" style:UIBarButtonItemStyleDone target:self action:@selector(pushToAirPrintEditingViewController)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
   
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc]initWithTitle:@"HealthKit" style:UIBarButtonItemStylePlain target:self action:@selector(pushToHealthkitViewController)];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    [self createTableView];
    
}
//拖拽视图
- (void)createDragView:(UIView *)currentView{
    LCFreeDragView *logoView=[[LCFreeDragView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    logoView.layer.cornerRadius=14;
    logoView.isKeepBounds=YES;
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emojiGif" ofType:@"gif"]];
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, logoView.bounds.size.width,logoView.bounds.size.height)];
    webView.scalesPageToFit=YES;
    [webView setOpaque:0];
    webView.userInteractionEnabled=NO;
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
    [logoView.contentViewForDrag addSubview:webView];
    
    [currentView addSubview:logoView];
    logoView.freeRect=CGRectMake(0, 64, currentView.frame.size.width, currentView.frame.size.height-64);
    logoView.center=currentView.center;
    
    logoView.ClickDragViewBlock=^(LCFreeDragView *dragView){

        dispatch_async(dispatch_get_main_queue(), ^{
           [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        });
        
    };
    logoView.beginDragBlock=^(LCFreeDragView *dragView){
        NSLog(@"开始拖拽");
    };
    logoView.EndDragBlock=^(LCFreeDragView *dragView){
        NSLog(@"结束拖拽");
    };

}
- (void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOWS.width, WINDOWS.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
    }
}
#pragma mark --tableViewdelegateAndDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const strID=@"strId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strID];
    }
    cell.textLabel.text=_mutArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self pushToH5AndCssViewController];
    }else if(indexPath.row==1){
        RootViewController *jsAndOc=[[RootViewController alloc]init];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:jsAndOc];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }else if (indexPath.row==2){
        CoordinatingController *vc=[CoordinatingController sharedinstance];
        [self.navigationController pushViewController:vc animated:YES];
    
    }else if (indexPath.row==3){
        LCCoreAnimationViewController *vc=[[LCCoreAnimationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
        LCLayerViewController *vc=[[LCLayerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }


}
/** H5+CSS+JS */
- (void)pushToH5AndCssViewController{
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:pageController];
    
    LCUIWebViewViewController *total=[[LCUIWebViewViewController alloc]init];
    total.localHtml=@"total.html";
    LCUIWebViewViewController *flight=[[LCUIWebViewViewController alloc]init];
    flight.localHtml=@"flight.html";
    LCUIWebViewViewController *traveller=[[LCUIWebViewViewController alloc]init];
    traveller.localHtml=@"travellerOn.html";
    LCUIWebViewViewController *place=[[LCUIWebViewViewController alloc]init];
    place.localHtml=@"placeOn.html";
    
    
    [navigationController.viewControllerArray addObjectsFromArray:@[total,flight,traveller,place]];
    [self createDragView:navigationController.view];
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
}

- (void)pushToHealthkitViewController{
    LCHealthKitViewController *healthVC=[[LCHealthKitViewController alloc]init];
    [self.navigationController pushViewController:healthVC animated:YES];

}
- (void)pushToAirPrintEditingViewController{
    TableViewController *vc=[[TableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
