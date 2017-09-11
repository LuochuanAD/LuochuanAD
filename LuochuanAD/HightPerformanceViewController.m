//
//  HightPerformanceViewController.m
//  LuochuanAD
//
//  Created by care on 2017/8/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "HightPerformanceViewController.h"
#import "TimerViewController.h"
#import "DelegateViewController.h"
#import "BlockViewController.h"
#import "MultiScreenViewController.h"
#import "BatteryAndCPUViewController.h"
@interface HightPerformanceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_mutArray;
}
@property (nonatomic, strong) NSArray *rowThreeTestDataArray;
@end

@implementation HightPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rowThreeTestDataArray=[NSArray array];
    _mutArray=@[@"定时器10秒获取数据高兴 分类",@"委托 解决循环引用",@"块",@"多屏",@"电池与cpu"];
    [self createTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //阻止屏幕变暗,非常耗电,慎用
    [UIApplication sharedApplication].idleTimerDisabled=YES;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].idleTimerDisabled=NO;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        TimerViewController *vc=[[TimerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row==1){
        DelegateViewController *vc=[[DelegateViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        NSLog(@"---%@",self.rowThreeTestDataArray);
        BlockViewController *vc=[[BlockViewController alloc]init];
        __weak typeof(self) weakSelf=self;
        [self presentViewController:vc animated:YES completion:^{
            typeof(self) theSelf=weakSelf;
            if (theSelf!=nil) {
                theSelf.rowThreeTestDataArray=vc.dataArray;
                [theSelf dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"===%@",theSelf.rowThreeTestDataArray);
                }];
            }
        }];
        
    }else if (indexPath.row==3){
        MultiScreenViewController *multiScreenVC=[[MultiScreenViewController alloc]init];
        [self.navigationController pushViewController:multiScreenVC animated:YES];
    }else if (indexPath.row==4){
        BatteryAndCPUViewController *vc=[[BatteryAndCPUViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s %@",__PRETTY_FUNCTION__,self.rowThreeTestDataArray);

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
