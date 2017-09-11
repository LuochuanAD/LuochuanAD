//
//  MultiScreenViewController.m
//  LuochuanAD
//
//  Created by care on 2017/9/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "MultiScreenViewController.h"
#import "SecondViewController.h"
@interface MultiScreenViewController ()
@property (nonatomic, strong) UIWindow *secondWindow;
@end

@implementation MultiScreenViewController

- (void)dealloc{
    [self unregisterNotifications];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotifications];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateScreens];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self disConnectFromScreen];

}
- (void)disConnectFromScreen{
    if (self.secondWindow!=nil) {
        self.secondWindow.rootViewController=nil;
        self.secondWindow.hidden=YES;
        self.secondWindow=nil;
    }
}
- (void)registerNotifications{
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(screenChanged:) name:UIScreenDidConnectNotification object:nil];
    [nc addObserver:self selector:@selector(screenChanged:) name:UIScreenDidDisconnectNotification object:nil];
}
- (void)updateScreens{
    NSArray *screens=[UIScreen screens];
    if (screens.count>1) {
        UIScreen *secondScreen=(UIScreen *)[screens objectAtIndex:1];
        CGRect rect=secondScreen.bounds;
        if (self.secondWindow==nil) {
            self.secondWindow=[[UIWindow alloc]initWithFrame:rect];
            self.secondWindow.screen=secondScreen;
            SecondViewController *secondVC=[[SecondViewController alloc]init];
            self.secondWindow.rootViewController=secondVC;
        }
        self.secondWindow.hidden=NO;
    }else{
        [self disConnectFromScreen];
    
    }


}
- (void)screenChanged:(NSNotification *)n{
    [self updateScreens];
}
- (void)unregisterNotifications{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
