//
//  LCPassBookTypeViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCPassBookTypeViewController.h"
#import "BoardingPassViewController.h"
#import "CouponViewController.h"
#import "GenericViewController.h"
#import "StoreCardViewController.h"
#import "EventViewController.h"
@interface LCPassBookTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *typeArray;
}
@property (nonatomic, strong) UITableView *typeTableView;
@end

@implementation LCPassBookTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    typeArray=@[@"Boarding Pass(登机牌)",@"Coupon(优惠券)",@"Event(优惠券)",@"Generic(通用卡)",@"Store Card(购物卡)"];
    _typeTableView=[self setUPTableView];
    [self.view addSubview:_typeTableView];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"当前功能需要开启wallet,在项目capalities中设置" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles:nil];
    [alert show];

}
- (UITableView *)setUPTableView{
    if (!_typeTableView) {
        _typeTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _typeTableView.delegate=self;
        _typeTableView.dataSource=self;
    }
    return _typeTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return typeArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID=@"strID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.textLabel.text=typeArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        BoardingPassViewController *vc=[[BoardingPassViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        CouponViewController *vc=[[CouponViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        EventViewController *vc=[[EventViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3){
        GenericViewController *vc=[[GenericViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
        StoreCardViewController *vc=[[StoreCardViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
@end
