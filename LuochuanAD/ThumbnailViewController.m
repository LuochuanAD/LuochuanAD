//
//  ThumbnailViewController.m
//  LuochuanAD
//
//  Created by care on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ThumbnailViewController.h"

@interface ThumbnailViewController ()

@end

@implementation ThumbnailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_texture"]];
    self.view.backgroundColor=backgroundColor;
    
    _scribblemanager=[[ScribbleManager alloc]init];
    NSInteger numberOfScribbles=[_scribblemanager numberOfScribbles];
    [_navigationItem setTitle:[NSString stringWithFormat:numberOfScribbles>1?@"%ld items":@"%ld item",(long)numberOfScribbles]];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CGFloat numberOfPlaceholders=[ScribbleThumbnailCell numberOfPalaceholders];
    NSInteger numberOfScribbles=[_scribblemanager numberOfScribbles];
    NSInteger numberOfRows=ceil(numberOfScribbles/numberOfPlaceholders);
    return numberOfRows;
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID=@"strID";
    ScribbleThumbnailCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell=[[ScribbleThumbnailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSInteger numberOfSupportedThumbnails=[ScribbleThumbnailCell numberOfPalaceholders];
    NSUInteger rowIndex=[indexPath row];
    NSInteger thumbnailindex=rowIndex*numberOfSupportedThumbnails;
    NSInteger numberOfScribble=[_scribblemanager numberOfScribbles];
    for (NSInteger i=0; i<numberOfSupportedThumbnails&&(thumbnailindex=1)<numberOfScribble; i++) {
        UIView *scribbleThumbnail=[_scribblemanager scribbleThumbnailViewAtIndex:thumbnailindex+1];
        [cell addThumbnailView:scribbleThumbnail atIndex:i];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
@end
