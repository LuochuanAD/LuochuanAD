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

@property (nonatomic, strong)DelegateUpdateTask *task;
@end

@implementation DelegateViewController

-(void)dealloc{
    NSLog(@"%s called",__PRETTY_FUNCTION__);
    if (self.task!=nil) {
        [self.task cancel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(refresh) withObject:nil afterDelay:10];
}
- (void)refresh{
    NSLog(@"%s enter",__PRETTY_FUNCTION__);
    self.task=[[DelegateUpdateTask alloc]init];
    self.task.delegate=self;
    [self.task startUpdate];
    NSLog(@"%s exit",__PRETTY_FUNCTION__);
}
- (void)onDataAvailable:(NSArray *)records{
    NSLog(@"%s called",__PRETTY_FUNCTION__);
    NSLog(@"--------更新--------%@",records);
    self.task=nil;
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
