//
//  LCHealthKitViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCHealthKitViewController.h"
#import "HKHealthStore+AAPLExtensions.h"
@interface LCHealthKitViewController ()

@end

@implementation LCHealthKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getAuthority];
}
//iOS8及非iPad
- (void)getAuthority{
    if (![HKHealthStore isHealthDataAvailable]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"该设备不支持HealthKit" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
        [alert show];
    }else{
        self.healthStore=[[HKHealthStore alloc]init];
        NSSet *writeDataTypes=[self dataTypesToWrite];
        NSSet *readDataTypes=[self dataTypesToRead];
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"获取健康数据权限失败,请检查并允许" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
                [alert show];
                ;
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateBrithDay];
                    [self updateWeight];
                    [self updateHeight];
                    [self updateStep];
                    [self updateTemp];
                });
                
            }
        }];
    }
    
    

}
//身高/体重/体温
- (NSSet *)dataTypesToWrite{
    HKObjectType *heightType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKObjectType *weightType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKObjectType *tempType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    
    return [NSSet setWithObjects:tempType,heightType,weightType, nil];

}
- (NSSet *)dataTypesToRead{
    HKObjectType *heightType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKObjectType *weightType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKObjectType *tempType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKObjectType *stepType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKCharacteristicType *birthdayType=[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *sexType=[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    HKCharacteristicType *bloodType=[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    HKCharacteristicType *skinType=[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierFitzpatrickSkinType];
    
    return [NSSet setWithObjects:heightType,weightType,stepType,birthdayType,sexType,bloodType,skinType,tempType, nil];

}
- (void)updateTemp{
    HKQuantityType *recentTemp=[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    [self.healthStore aapl_mostRecentQuantitySampleOfType:recentTemp predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
        
            dispatch_async(dispatch_get_main_queue(), ^{
               self.mostRescent.text=@"没有最近的体温记录";
            });
        }else{
            HKUnit *kelvinYnit=[HKUnit kelvinUnit];
            double temp=[mostRecentQuantity doubleValueForUnit:kelvinYnit];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.mostRescent.text=[NSString stringWithFormat:@"最近体温:%0.2f",[self convertUnitsFromKelvin:temp]];
            });
        
        }
    }];
    [self.healthStore allQuantitySampleOfType:recentTemp predicate:nil completion:^(NSArray *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有体温数据" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
            [alert show];
        }else{
            HKUnit *kelVinUnit=[HKUnit kelvinUnit];
            double max=0;
            double min=1000;
            
            double sum=0;
            int numberOfSamoles=0;
            double averageTemp=0;
            for (int i=0; i<[mostRecentQuantity count]; i++) {
                HKQuantitySample *sample=[mostRecentQuantity objectAtIndex:i];
                if ([[sample quantity] doubleValueForUnit:kelVinUnit] > max) {
                    max=[[sample quantity] doubleValueForUnit:kelVinUnit];
                }
                if ([[sample quantity] doubleValueForUnit:kelVinUnit] < min) {
                    min=[[sample quantity] doubleValueForUnit:kelVinUnit];
                }
                if ([[sample startDate] timeIntervalSinceNow]<604800.0) {
                    sum +=[[sample quantity] doubleValueForUnit:kelVinUnit];
                    numberOfSamoles++;
                }
            }
            averageTemp=sum/numberOfSamoles;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.haighTemp.text=[NSString stringWithFormat:@"最高体温:%0.2f",[self convertUnitsFromKelvin:max]];
                self.downTemp.text=[NSString stringWithFormat:@"最低体温%0.2f",[self convertUnitsFromKelvin:min]];
                self.averageTemp.text=[NSString stringWithFormat:@"一周平均体温%0.2f",[self convertUnitsFromKelvin:averageTemp]];
             });
        
        }
    }];

}
- (void)updateBrithDay{
    NSError *error=nil;
    NSDate *dateOfBirth=[self.healthStore dateOfBirthWithError:&error];
    if (!dateOfBirth) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取生日失败,请在健康APP这种填写" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
            [alert show];
        });
        
    }else{
        NSDate *now=[NSDate date];
        NSDateComponents *ageComponents=[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dateOfBirth toDate:now options:NSCalendarWrapComponents];
        NSUInteger usersAge=[ageComponents year];
        dispatch_async(dispatch_get_main_queue(), ^{
           self.ageTextFiled.text=[NSString stringWithFormat:@"年龄:%@",[NSNumberFormatter localizedStringFromNumber:@(usersAge) numberStyle:NSNumberFormatterNoStyle]];
        });
        
        
        
    }


}
- (void)updateWeight{
    HKQuantityType *weightType=[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    [self.healthStore aapl_mostRecentQuantitySampleOfType:weightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取体重失败,请在健康APP这种填写" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
                [alert show];
            });
        }else{
            HKUnit *weightUnit=[HKUnit poundUnit];
            double userWeight=[mostRecentQuantity doubleValueForUnit:weightUnit];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.weightTextFiled.text=[NSString stringWithFormat:@"体重:%@",[NSNumberFormatter localizedStringFromNumber:@(userWeight) numberStyle:NSNumberFormatterNoStyle]];
            });
            
        }
    }];


}
- (void)updateHeight{
    HKQuantityType *heightType=[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    [self.healthStore aapl_mostRecentQuantitySampleOfType:heightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取身高失败,请在健康APP这种填写" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
                [alert show];
            });
        }else{
            HKUnit *heightUnit=[HKUnit inchUnit];
            double userHeight=[mostRecentQuantity doubleValueForUnit:heightUnit];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.heightTextFiled.text=[NSString stringWithFormat:@"身高:%@",[NSNumberFormatter localizedStringFromNumber:@(userHeight) numberStyle:NSNumberFormatterNoStyle]];
            });
            
        }
        
    }];



}
- (void)updateStep{
    HKSampleType *sampleType=[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *start=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    NSDate *now=[NSDate date];
    NSCalendar *calender=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *dateComponents=[calender components:unitFlags fromDate:now];
    int hour=(int)[dateComponents hour];
    int minute=(int)[dateComponents minute];
    int second=(int)[dateComponents second];
    NSDate *nowDay=[NSDate dateWithTimeIntervalSinceNow:-(hour*3600+minute*60+second)];
    NSDate *nextDay=[NSDate dateWithTimeIntervalSinceNow:-(hour*3600+minute*60+second)+86400];
    NSPredicate *predicate=[HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    
    HKSampleQuery *sampleQuery=[[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:1 sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        int allStepCount=0;
        for (int i=0; i<results.count; i++) {
            HKQuantitySample *result=results[i];
            HKQuantity *quantity=result.quantity;
            NSMutableString *stepCount=(NSMutableString *)quantity;
            NSString *stepStr=[NSString stringWithFormat:@"%@",stepCount];
            NSString *str=[stepStr componentsSeparatedByString:@" "][0];
            int stepNum=[str intValue];
            allStepCount=allStepCount+stepNum;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           self.stepTextFiled.text=[NSString stringWithFormat:@"步数:%d",allStepCount];
        });
        
    }];
    [self.healthStore executeQuery:sampleQuery];

}
- (void)saveHeightIntoHealthStore:(double)height
{
    HKUnit *inchUnit = [HKUnit inchUnit];
    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:inchUnit doubleValue:height];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:heightSample withCompletion:^(BOOL success, NSError *error)
     {
         if (!success)
         {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"保存失败(%@): %@.", heightSample, error] delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
                 [alert show];
             });
         }
         
         [self updateHeight];
     }];
}

- (void)saveWeightIntoHealthStore:(double)weight {
    HKUnit *poundUnit = [HKUnit poundUnit];
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:poundUnit doubleValue:weight];
    
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error)
     {
         if (!success)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"保存失败(%@): %@.", weightSample, error] delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
                 [alert show];
             });
         }
         
         [self updateWeight];
     }];
}
-(void)saveMostRecentTemp:(double)temp
{
    double adjustedTemp = 0;
    
    //F to Kelvin
    if([self.segmentControl selectedSegmentIndex] == 0)
    {
        adjustedTemp = ((temp-32)/1.8)+273.15;
    }
    
    //C to Kelvin
    if([self.segmentControl selectedSegmentIndex] == 1)
    {
        adjustedTemp = temp+273.15;
    }
    
    // Save the user's height into HealthKit.
    HKUnit *kelvinUnit = [HKUnit kelvinUnit];
    HKQuantity *tempQuainity = [HKQuantity quantityWithUnit:kelvinUnit doubleValue:adjustedTemp];
    
    HKQuantityType *tempType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *tempSample = [HKQuantitySample quantitySampleWithType:tempType quantity:tempQuainity startDate:now endDate:now];
    
    [self.healthStore saveObject:tempSample withCompletion:^(BOOL success, NSError *error)
     {
         if (!success)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"保存失败(%@): %@.", tempSample, error] delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
                 [alert show];
             });

         }
         
         [self updateTemp];
     }];
    
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

- (IBAction)save:(id)sender {
    [self saveHeightIntoHealthStore:[self.heightTextFiled.text doubleValue]];
    [self saveWeightIntoHealthStore:[self.weightTextFiled.text doubleValue]];
    [self updateBrithDay];
    [self.heightTextFiled resignFirstResponder];
    [self.weightTextFiled resignFirstResponder];
}

-(double)convertUnitsFromKelvin:(double)kelvinUnits
{
    double adjustedTemp = 0;
    
    //Kelvin to F
    if([self.segmentControl selectedSegmentIndex] == 0)
    {
        adjustedTemp = ((kelvinUnits-273.15)*1.8)+32;
    }
    
    //Kelvin to C
    if([self.segmentControl selectedSegmentIndex] == 1)
    {
        adjustedTemp = kelvinUnits-273.15;
    }
    
    return adjustedTemp;
}
- (IBAction)updateSelect:(UISegmentedControl *)sender {
    [self updateTemp];
    
}

- (IBAction)saveTemp:(id)sender {
    
    
    [self saveMostRecentTemp:[self.tempTextFiled.text doubleValue]];
    [self.tempTextFiled resignFirstResponder];
}
@end
