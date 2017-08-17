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
@interface HightPerformanceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_mutArray;
}
@end

@implementation HightPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mutArray=@[@"定时器10秒获取数据高兴 分类",@"委托 解决循环引用"];
    [self createTableView];
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
        
        
    }
    
    
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
