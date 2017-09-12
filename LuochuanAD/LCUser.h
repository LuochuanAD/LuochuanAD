//
//  LCUser.h
//  LuochuanAD
//
//  Created by care on 2017/9/12.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUser : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSDate *dateOfBirth;
@property (nonatomic, strong) NSArray *albums;
@end
