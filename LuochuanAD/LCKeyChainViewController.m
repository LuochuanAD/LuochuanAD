//
//  LCKeyChainViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/22.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCKeyChainViewController.h"

@interface LCKeyChainViewController ()

@end

@implementation LCKeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self saveDictionary];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self readDictionary];

}

- (void)saveDictionary{

    NSMutableDictionary *secureDict=[[NSMutableDictionary alloc]init];
    NSError *error=nil;
    [secureDict setObject:@"LuochuanAD" forKey:@"username"];
    [secureDict setObject:@"Chief software engineer" forKey:@"job"];
    [secureDict setObject:@"https://github.com/LuochuanAD" forKey:@"github"];
    [secureDict setObject:@"luochuanpersonal@163.com" forKey:@"email"];
    NSData *secureData=[NSJSONSerialization dataWithJSONObject:secureDict options:0 error:&error];
    if (!error) {
        NSLog(@"save data error:%@",[error localizedDescription]);
    }
    NSString *dataString=[[NSString alloc]initWithData:secureData encoding:NSUTF8StringEncoding];
    keyWrapper=[[KeychainItemWrapper alloc]initWithIdentifier:@"come.luochuanAD.LuochuanAD" accessGroup:nil];
    [keyWrapper setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
    [keyWrapper setObject:@"LuochuanAD" forKey:(__bridge id)(kSecAttrAccount)];
    if ([[keyWrapper objectForKey:(__bridge id)(kSecValueData)] length]==0) {
        [keyWrapper setObject:dataString forKey:(__bridge id)(kSecValueData)];
    }
    

}
- (void)readDictionary{
    NSString *secureString=[keyWrapper objectForKey:(__bridge id)(kSecValueData)];
    if ([secureString length]>0) {
        NSData *data=[secureString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        NSDictionary *secureDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            NSLog(@"read dict error:%@",[error localizedDescription]);
        }
        
        NSString *userName=[secureDict objectForKey:@"username"];
        NSString *job=[secureDict objectForKey:@"job"];
        NSString *github=[secureDict objectForKey:@"github"];
        NSString *email=[secureDict objectForKey:@"email"];
        NSLog(@"%@,%@,%@,%@",userName,job,github,email);
        
    }
}

@end
