//
//  UIViewController+getContactInfo.m
//  LuochuanAD
//
//  Created by care on 17/5/2.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "UIViewController+getContactInfo.h"
#define Is_up_Ios_9      ([[UIDevice currentDevice].systemVersion floatValue]) >= 9.0

@implementation UIViewController (getContactInfo)

void(^addressBlock)(NSDictionary *);

- (void)CheckAddressBookAuthorizationAndPersonInform:(void(^)(NSDictionary *data))handler{
    addressBlock=[handler copy];
    if (Is_up_Ios_9) {
        CNContactStore *contactStore=[[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]==CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error:%@",error);
                }else if (!granted){
                
                //ios9无权限
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告:无权限" message:@"请到设置>隐私>通讯录打开本应用的权限设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }else{
                //ios9有权限
                    [self methodForNineOrMore];
                }
            }];
        }else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]==CNAuthorizationStatusAuthorized){
        //ios9有权限
            [self methodForNineOrMore];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告:无权限" message:@"请到设置>隐私>通讯录打开本应用的权限设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }else{
        CFErrorRef *error=nil;
        ABAddressBookRef addressBook=ABAddressBookCreateWithOptions(nil, error);
        ABAuthorizationStatus authStatues=ABAddressBookGetAuthorizationStatus();
        if (authStatues==kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   if (error) {
                       NSLog(@"Error; %@",(__bridge NSError *)error);
                   }else if (!granted){
                       //ios9以下无权限
                       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告:无权限" message:@"请到设置>隐私>通讯录打开本应用的权限设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                       [alert show];
                   }else{
                       //ios9以下有权限
                       [self methodForNineOrLess];
                   
                   }
               });
            });
        }else if (authStatues==kABAuthorizationStatusAuthorized){
            //ios9以下有权限
            [self methodForNineOrLess];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告:无权限" message:@"请到设置>隐私>通讯录打开本应用的权限设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    
    
    }

}
//iOS9及以上
- (void)methodForNineOrMore{
    CNContactPickerViewController *contactPicker=[[CNContactPickerViewController alloc]init];
    contactPicker.delegate=self;
    contactPicker.displayedPropertyKeys=@[CNContactPhoneNumbersKey];
    [self presentViewController:contactPicker animated:YES completion:^{
        
    }];
}
//iOS9以下
- (void)methodForNineOrLess{
    ABPeoplePickerNavigationController *peoplePicker=[[ABPeoplePickerNavigationController alloc]init];
    peoplePicker.peoplePickerDelegate=self;
    [self presentViewController:peoplePicker animated:YES completion:^{
        
    }];

}
//iOS9通讯代理
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    CNPhoneNumber *phoneNumber=(CNPhoneNumber *)contactProperty.value;
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *text1=[NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
        NSString *text2=phoneNumber.stringValue;
        NSDictionary *dic=@{@"name":text1,@"phone":text2};
        addressBlock(dic);
    }];

}
//iOS9以下代理
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    ABMultiValueRef valuesRef=ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index=ABMultiValueGetIndexForIdentifier(valuesRef, identifier);
    CFStringRef value=ABMultiValueCopyValueAtIndex(valuesRef,index);
    CFStringRef anFullName=ABRecordCopyCompositeName(person);
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *text1=[NSString stringWithFormat:@"%@",anFullName];
        NSString *text2=(__bridge NSString *)value;
        NSDictionary *dic=@{@"name":text1,@"phone":text2};
        addressBlock(dic);
    }];
}
@end
