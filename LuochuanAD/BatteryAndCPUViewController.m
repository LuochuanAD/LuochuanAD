//
//  BatteryAndCPUViewController.m
//  LuochuanAD
//
//  Created by care on 2017/9/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "BatteryAndCPUViewController.h"
#import <mach/mach.h>
@interface BatteryAndCPUViewController ()

@end

@implementation BatteryAndCPUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"密集型操作" style:UIBarButtonItemStyleDone target:self action:@selector(doIntensiveOperation)];
    self.navigationItem.rightBarButtonItem=rightItem;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self computeAndRefresh];
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(batteryStateOrLevelChanged) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    [nc addObserver:self selector:@selector(batteryStateOrLevelChanged) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIDeviceBatteryStateDidChangeNotification object:nil];
    [nc removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification object:nil];
}
- (void)doIntensiveOperation{
    BOOL prompt=YES;
    int minLevel=30;
    BOOL canAutoProceed=[self shouldProcessedWithMinLevel:minLevel];
    if (canAutoProceed==YES) {
        NSLog(@"------开始计算--------");
        __weak BatteryAndCPUViewController *weakSelf=self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            BatteryAndCPUViewController *strongSelf=weakSelf;
            if (strongSelf) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.navigationItem.rightBarButtonItem.enabled=NO;
                });
                [strongSelf cpuIntensiveOperation];
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.navigationItem.rightBarButtonItem.enabled=YES;
                });
            }
        });
    }else{
        if (prompt==YES) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"电池电量小于最低水平" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
            [alert show];
        }else{
            NSLog(@"-----没有足够的电量------");
        
        }
    
    }


}
- (void)cpuIntensiveOperation{
    double x=0;
    for (int i=0; i<5000000; i++) {
        x=sqrt(pow(sin(i), 2))+pow(cos(i), 2);
    }
    NSLog(@"----cpuIntensiveOperation-----x:%lf",x);

}
- (BOOL)shouldProcessedWithMinLevel:(int)minLevel{
    UIDevice *device=[UIDevice currentDevice];
    device.batteryMonitoringEnabled=YES;
    UIDeviceBatteryState state=device.batteryState;
    if (state==UIDeviceBatteryStateCharging||state==UIDeviceBatteryStateFull) {
        return YES;
    }
    int batteryLevel=(int)(device.batteryLevel*100);
    if (batteryLevel>=minLevel) {
        return YES;
    }
    return NO;

}
- (void)batteryStateOrLevelChanged{
    [self computeAndRefresh];

}
- (void)computeAndRefresh{
    UIDevice *device=[UIDevice currentDevice];
    device.batteryMonitoringEnabled=YES;
    float batteryLevel=device.batteryLevel;
    NSLog(@"----电池电量-------%@ %%",[NSString stringWithFormat:@"~%d%%", (int)(batteryLevel * 100)]);
    UIDeviceBatteryState state=device.batteryState;
    NSString *stateValue=@"";
    switch (state) {
        case UIDeviceBatteryStateCharging:
            stateValue=@"正在充电";
            break;
        case UIDeviceBatteryStateUnplugged:
            stateValue=@"未充电";
            break;
        case UIDeviceBatteryStateFull:
            stateValue=@"已充满";
            break;
        case UIDeviceBatteryStateUnknown:
            stateValue=@"未知";
            break;
        
    }
    NSLog(@"------电池状态-------%@",stateValue);
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    infoCount=HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
    int coreCount=hostInfo.max_cpus;
    uint64_t maxMemory =hostInfo.max_mem;
    NSLog(@"------多核个数-------%d",coreCount);
    NSLog(@"-------内存----------%.2fM",(maxMemory*1.0f/(1024*1024)));
    task_basic_info_data_t info;
    mach_msg_type_number_t size=sizeof(info);
    kern_return_t kerr=task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    NSLog(@"--------内存消耗---------%.2fM",((kerr==KERN_SUCCESS)?(info.resident_size*1.0/(1024*1024)):0));
    NSLog(@"-----cpu状态----%@",[[self cpuUsage] componentsJoinedByString:@","]);
    NSLog(@"-------appCpu状态------------%.2f%%",[self appCpuUsage]);

}
//cpu使用
- (NSArray *)cpuUsage{
    NSMutableArray *rv=[[NSMutableArray alloc]init];
    processor_info_array_t cpuInfo=NULL;
    mach_msg_type_number_t numCPUInfo=0;
    NSUInteger numCPUs=[NSProcessInfo processInfo].processorCount;
    natural_t nCPUs=0;
    kern_return_t kerr=host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &nCPUs, &cpuInfo, &numCPUInfo);
    if (kerr==KERN_SUCCESS) {
        for (NSUInteger i=0; i<numCPUs; i++) {
            float inUse,total;
            inUse=cpuInfo[(CPU_STATE_MAX*i)+CPU_STATE_USER]+cpuInfo[(CPU_STATE_MAX*i)+CPU_STATE_SYSTEM]+cpuInfo[(CPU_STATE_MAX*i)+CPU_STATE_NICE];
            total=inUse+cpuInfo[(CPU_STATE_MAX*i)+CPU_STATE_IDLE];
            [rv addObject:[NSString stringWithFormat:@"%.2f%%",inUse/total*100.0f]];
        }
    }

    return rv;
}
//app cpu使用
- (float)appCpuUsage{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    task_info_count =TASK_INFO_MAX;
    kr=task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr!=KERN_SUCCESS) {
        return -1;
    }
    thread_array_t thread_list;
    mach_msg_type_number_t thread_count;
    thread_info_data_t thinfo;
    mach_msg_type_number_t thread_info_count;
    thread_basic_info_t basic_info_th;
    kr=task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr!=KERN_SUCCESS) {
        return -1;
    }
    float tot_cpu=0;
    int j;
    for (j=0; j<thread_count; j++) {
        thread_info_count=THREAD_INFO_MAX;
        kr=thread_info(thread_list[j], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr!=KERN_SUCCESS) {
            return -1;
        }
        basic_info_th=(thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags&TH_FLAGS_IDLE)) {
            tot_cpu=tot_cpu+basic_info_th->cpu_usage/(float)TH_USAGE_SCALE*100.0;
        }
    }
    kr=vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count*sizeof(thread_t));
    assert(kr==KERN_SUCCESS);

    return tot_cpu;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
