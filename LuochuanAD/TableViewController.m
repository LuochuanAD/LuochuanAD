//
//  TableViewController.m
//  LuochuanAD
//
//  Created by care on 17/1/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "TableViewController.h"

#import "LCAirPrintEditingViewController.h"
#import "LCAirPrintWebViewController.h"
#import "LCAirPrintHtmlViewController.h"
//textKit(非打印机)
#import "LCTextViewKitViewController.h"
#import "LCExculsionPathTextViewController.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mutArray;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mutArray=[[NSMutableArray alloc]initWithObjects:@"YYText图文混排(打印)",@"网站(打印)",@"Html(自定义打印机)",@"TextKit(非打印机)",@"textView路径排除(非打印机)", nil];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return mutArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strID=@"strID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
        
    }
    cell.tag=indexPath.row+100;
    
    cell.textLabel.text=mutArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        LCAirPrintEditingViewController *vc=[[LCAirPrintEditingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        LCAirPrintWebViewController *vc=[[LCAirPrintWebViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        LCAirPrintHtmlViewController *vc=[[LCAirPrintHtmlViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    
    }else if (indexPath.row==3){
        LCTextViewKitViewController *textKitVC=[[LCTextViewKitViewController alloc]init];
        [self.navigationController pushViewController:textKitVC animated:YES];
    }else if (indexPath.row==4){
        LCExculsionPathTextViewController *exculsionPathVC=[[LCExculsionPathTextViewController alloc]init];
        [self.navigationController pushViewController:exculsionPathVC animated:YES];
    }else if (indexPath.row==5){
        
    
    }

}

@end
