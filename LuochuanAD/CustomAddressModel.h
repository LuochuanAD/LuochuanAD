//
//  CustomAddressModel.h
//  LuochuanAD
//
//  Created by care on 17/5/3.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "FatherModel.h"

@interface CustomAddressModel : FatherModel
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *personPhone;
@property (nonatomic, copy) NSData * iconImage;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *address;
@end
