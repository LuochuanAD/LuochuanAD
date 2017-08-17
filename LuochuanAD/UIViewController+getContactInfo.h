//
//  UIViewController+getContactInfo.h
//  LuochuanAD
//
//  Created by care on 17/5/2.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
//iOS9以下
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
//iOS9
#import <ContactsUI/ContactsUI.h>

#define Is_up_Ios_9      ([[UIDevice currentDevice].systemVersion floatValue]) >= 9.0

@interface UIViewController (getContactInfo)<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>
//通讯录联系人信息
- (void)CheckAddressBookAuthorizationAndPersonInform:(void(^)(NSDictionary *data))handler;

@end
