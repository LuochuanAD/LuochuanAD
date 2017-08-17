//
//  TimerViewController.m
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "TimerViewController.h"
#import "TimeUpdateTask.h"
#import "timeSourceModel.h"
@interface TimerViewController ()
@property (nonatomic, strong) TimeUpdateTask *updateTask;

@end

@implementation TimerViewController
- (void)dealloc{
    [self.updateTask shutDwon];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //10秒后获取数据 更新UI
    self.updateTask=[[TimeUpdateTask alloc]initWithTimeInterval:10 target:self selector:@selector(updateUsingModel:)];
    
}
- (void)updateUsingModel:(timeSourceModel *)model{
    NSLog(@"%@----------%@",model.name,model.age);

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
