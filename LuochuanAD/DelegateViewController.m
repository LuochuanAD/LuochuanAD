//
//  DelegateViewController.m
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "DelegateViewController.h"
#import "DelegateUpdateTask.h"
@interface DelegateViewController ()<UpdateTaskDelegate>
{
    DelegateUpdateTask *task;
}
@end

@implementation DelegateViewController

-(void)dealloc{
    if (task!=nil) {
        [task cancel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(refresh) withObject:nil afterDelay:10];
}
- (void)refresh{
    task=[[DelegateUpdateTask alloc]init];
    task.delegate=self;
    [task startUpdate];
    task=nil;
}
- (void)onDataAvailable:(NSArray *)records{
    NSLog(@"--------更新--------%@",records);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
