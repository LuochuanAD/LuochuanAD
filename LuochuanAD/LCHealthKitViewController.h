//
//  LCHealthKitViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
@interface LCHealthKitViewController : UIViewController
//年龄,身高,体重,步数
@property (weak, nonatomic) IBOutlet UITextField *ageTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *heightTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *weightTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *stepTextFiled;
- (IBAction)save:(id)sender;

//体温

@property (weak, nonatomic) IBOutlet UITextField *tempTextFiled;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)updateSelect:(UISegmentedControl *)sender;

- (IBAction)saveTemp:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mostRescent;
@property (weak, nonatomic) IBOutlet UILabel *haighTemp;

@property (weak, nonatomic) IBOutlet UILabel *downTemp;

@property (weak, nonatomic) IBOutlet UILabel *averageTemp;



@property (nonatomic, strong)HKHealthStore *healthStore;
@end
