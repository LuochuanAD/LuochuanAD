//
//  PrototypeController.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "PrototypeController.h"
#import "Mark.h"
#import "CanvasView.h"
@interface PrototypeController ()

@end

@implementation PrototypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<Mark>selectedMark;
    NSMutableArray *templateArray=[[NSMutableArray alloc]initWithCapacity:1];
    id<Mark>patternTemolate=[selectedMark copy];
    
    [templateArray addObject:patternTemolate];
    
    CanvasView *canvasView;
    id <Mark>currentmark;
    int patternIndex = 0;
    
    id<Mark>patternClone=[templateArray objectAtIndex:patternIndex];
    [currentmark addMark:patternClone];
    [canvasView setMark:currentmark];
    [canvasView setNeedsDisplay];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
