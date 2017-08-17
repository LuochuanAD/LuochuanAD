//
//  LCForwardTwoViewController.m
//  LuochuanAD
//
//  Created by care on 16/12/28.
//  Copyright © 2016年 luochuan. All rights reserved.
//

#import "LCForwardTwoViewController.h"
#import "UIViewController+getContactInfo.h"
#import "LCContactDetailViewController.h"
#import "LCAddNewContactPersonViewController.h"
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
#import "pinyin.h"
@interface LCForwardTwoViewController ()
{
    //数据源 包括联系人姓名和电话等
    NSMutableArray *_sourceArr;
    //另外的分组数组
    NSMutableArray *_otherArr;
    //listData
    NSMutableArray *_dataArr;
    //分区的头标
    NSMutableArray *_titleArr;
    
    NSMutableArray *sectionTitleArray;
    
    ABAddressBookRef addressBookRef;
}
@end

@implementation LCForwardTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 点击获取联系人
    [self CheckAddressBookAuthorizationAndPersonInform:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if (data!=nil) {
            NSLog(@"%@%@",data[@"name"],data[@"phone"]);
            lable.text=data[@"name"];
            lable1.text=data[@"phone"];
        }
    }];
    */
    self.title=@"通讯录";
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewContactPerson:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    sectionTitleArray=[[NSMutableArray alloc]init];
    
    [self createTableView];
    [self loadPerson];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    
}
-(void)dataConfig{
    _dataArr = [[NSMutableArray alloc] init];
    _titleArr = [[NSMutableArray alloc] init];
    _otherArr = [[NSMutableArray alloc] init];
    
    [self dataConfigTitle];
    [self dataConfigSection];
}

-(void)dataConfigTitle{
    //初始化头标题
    _titleArr = [[NSMutableArray alloc] init];
    //插入组标题数组
    NSArray *arr=[sectionTitleArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    for (int i = 0; i < arr.count; i++) {
        NSMutableArray *array = [NSMutableArray array];
        //放入空数组
        [_dataArr addObject:array];
        //放入标题
        [_titleArr addObject:arr[i]];
    }
    //加上其他的
    [_titleArr addObject:@"其他"];
    [_dataArr addObject:_otherArr];
}

-(void)dataConfigSection{
    for (CustomAddressModel *model in _sourceArr) {
        if (IsNilOrNull(model.firstName)) {
            model.firstName = @"";
        }
        if (IsNilOrNull(model.lastName)) {
            model.lastName = @"";
        }
        NSString *name = [NSString stringWithFormat:@"%@%@",model.firstName,model.lastName];
        if (IsStrEmpty(name)) {
            [[_dataArr lastObject] addObject:model];
        }else{
            char c = pinyinFirstLetter([name characterAtIndex:0]);
            if (c>='a'&&c<='z') {
                c +=('A'-'a');
            }
            NSString *str=[NSString stringWithFormat:@"%c",c];
           NSInteger index=[_titleArr indexOfObject:str];
            
            if (index<0||index>=sectionTitleArray.count) {
                [_dataArr.lastObject addObject:model];
            }else{
                [_dataArr[index] addObject:model];
            }
            
        }
    }
}





- (void)createTableView{
    self.tableView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId=@"strId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
    }
    CustomAddressModel *model = _dataArr[indexPath.section][indexPath.row];
    if (IsNilOrNull(model.firstName)) {
        model.firstName = @"";
    }
    if (IsNilOrNull(model.lastName)) {
        model.lastName = @"";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@",model.firstName,model.lastName];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomAddressModel *model = _dataArr[indexPath.section][indexPath.row];
    LCContactDetailViewController *contactVC=[[LCContactDetailViewController alloc]init];
    contactVC.model=model;
    [self.navigationController pushViewController:contactVC animated:YES];
    
}
#pragma mark - 加载数据
- (void)loadPerson{
    _sourceArr = [[NSMutableArray alloc] init];
    addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            //CFErrorRef *error1 = NULL;
            //ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBookRef];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        //CFErrorRef *error = NULL;
        //ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBookRef];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"通讯录无权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        });
    }
}
- (void)copyAddressBook:(ABAddressBookRef)addressBook{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for ( int i = 0; i < numberOfPeople; i++){
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        CustomAddressModel *model = [[CustomAddressModel alloc] init];
        ABMultiValueRef firstName = (ABRecordCopyValue(person, kABPersonFirstNameProperty));
        ABMultiValueRef lastName = (ABRecordCopyValue(person, kABPersonLastNameProperty));
        model.firstName = (__bridge NSString*)firstName;
        model.lastName = (__bridge NSString*)lastName;
        
        NSString *name;
        NSString *test;
        
        if (model.firstName.length!=0||model.lastName.length!=0) {
            if (model.firstName.length==0&&model.lastName.length!=0) {
                name=[NSString stringWithFormat:@"%@",model.lastName];
            }else if (model.firstName.length!=0&&model.lastName.length==0){
                name=[NSString stringWithFormat:@"%@",model.firstName];
            }else if (model.firstName.length!=0&&model.lastName.length!=0){
                name=[NSString stringWithFormat:@"%@%@",model.firstName,model.lastName];
            }
            
            char c = pinyinFirstLetter([name characterAtIndex:0]);
            if (c>='a'&&c<='z') {
                c =c-'a'+'A';
            }
            
            test=[NSString stringWithFormat:@"%c",c];
            if (c>='A'&&c<='Z') {
                if (![sectionTitleArray containsObject:test]) {
                    [sectionTitleArray addObject:test];
                }
            }
            
        }

        CFBridgingRelease(firstName);
        CFBridgingRelease(lastName);
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        ABMultiValueRef personPhone = ABMultiValueCopyValueAtIndex(phone, 0);
        NSString *strFormat = [self phoneFromAddressTelphone:(__bridge NSString*)personPhone];
        model.personPhone = strFormat;
        CFBridgingRelease(personPhone);
        CFRelease(phone);
        
        //读取organization公司
        
        ABMultiValueRef organization = (ABRecordCopyValue(person, kABPersonOrganizationProperty));
        model.company=(__bridge NSString*)organization;
        CFBridgingRelease(organization);
        //读取jobtitle工作
        ABMultiValueRef jobtitle = (ABRecordCopyValue(person, kABPersonJobTitleProperty));
        model.job=(__bridge NSString*)jobtitle;
        CFBridgingRelease(jobtitle);
        //读取照片
        ABMultiValueRef image = (ABPersonCopyImageData(person));
        model.iconImage=(__bridge NSData*)image;
        CFBridgingRelease(image);
       // 获取email
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        
        ABMultiValueRef emailContent=ABMultiValueCopyValueAtIndex(email, 0);
        
        model.email=(__bridge NSString *)emailContent;
        CFBridgingRelease(emailContent);
        CFBridgingRelease(email);
        //读取地址
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        ABMultiValueRef dic=(ABMultiValueCopyValueAtIndex(address, 0));
        NSDictionary * temDic = (__bridge NSDictionary *)dic;
        //地址字符串，可以按需求格式化
        NSString * adressStr = [NSString stringWithFormat:@"国家:%@\n省:%@\n市:%@\n街道:%@\n邮编:%@",[temDic valueForKey:(NSString*)kABPersonAddressCountryKey],[temDic valueForKey:(NSString*)kABPersonAddressStateKey],[temDic valueForKey:(NSString*)kABPersonAddressCityKey],[temDic valueForKey:(NSString*)kABPersonAddressStreetKey],[temDic valueForKey:(NSString*)kABPersonAddressZIPKey]];
        
        model.address=adressStr;
        CFBridgingRelease(dic);
        CFBridgingRelease(address);
        
        
        [_sourceArr addObject:model];
    }
    CFRelease(people);
    //        NSString *middlename = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    //        //读取prefix前缀
    //        NSString *prefix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
    //        //读取suffix后缀
    //        NSString *suffix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
    //        //读取nickname呢称
    //        NSString *nickname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
    //        //读取firstname拼音音标
    //        NSString *firstnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
    //        //读取lastname拼音音标
    //        NSString *lastnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
    //        //读取middlename拼音音标
    //        NSString *middlenamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
    //        //读取organization公司
    //        NSString *organization = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
    //        //读取jobtitle工作
    //        NSString *jobtitle = (__bridge NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
    //        //读取department部门
    //        NSString *department = (__bridge NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
    //        //读取birthday生日
    //        NSDate *birthday = (__bridge NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
    //        //读取note备忘录
    //        NSString *note = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
    //        //第一次添加该条记录的时间
    //        NSString *firstknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
    //        NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
    //        //最后一次修改該条记录的时间
    //        NSString *lastknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
    //        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
    //
    //        //获取email多值
    //        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
    //        int emailcount = ABMultiValueGetCount(email);
    //        for (int x = 0; x < emailcount; x++)
    //        {
    //            //获取email Label
    //            NSString* emailLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
    //            //获取email值
    //            NSString* emailContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(email, x);
    //        }
    //        //读取地址多值
    //        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
    //        int count = ABMultiValueGetCount(address);
    //
    //        for(int j = 0; j < count; j++)
    //        {
    //            //获取地址Label
    //            NSString* addressLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
    //            //获取該label下的地址6属性
    //            NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
    //            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
    //            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
    //            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
    //            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
    //            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
    //            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
    //        }
    //
    //        //获取dates多值
    //        ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
    //        int datescount = ABMultiValueGetCount(dates);
    //        for (int y = 0; y < datescount; y++)
    //        {
    //            //获取dates Label
    //            NSString* datesLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
    //            //获取dates值
    //            NSString* datesContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(dates, y);
    //        }
    //        //获取kind值
    //        CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
    //        if (recordType == kABPersonKindOrganization) {
    //            // it's a company
    //            NSLog(@"it's a company\n");
    //        } else {
    //            // it's a person, resource, or room
    //            NSLog(@"it's a person, resource, or room\n");
    //        }
    //
    //
    //        //获取IM多值
    //        ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
    //        for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
    //        {
    //            //获取IM Label
    //            NSString* instantMessageLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
    //            //获取該label下的2属性
    //            NSDictionary* instantMessageContent =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
    //            NSString* username = [instantMessageContent valueForKey:(__bridge NSString *)kABPersonInstantMessageUsernameKey];
    //
    //            NSString* service = [instantMessageContent valueForKey:(__bridge NSString *)kABPersonInstantMessageServiceKey];
    //        }
    //获取URL多值
    //        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
    //        for (int m = 0; m < ABMultiValueGetCount(url); m++)
    //        {
    //            //获取电话Label
    //            NSString * urlLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
    //            //获取該Label下的电话值
    //            NSString * urlContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(url,m);
    //        }
    //
    //        //读取照片
    //        NSData *image = (__bridge NSData*)ABPersonCopyImageData(person);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self dataConfig];
        [self.tableView reloadData];
    });
}

- (NSString *)phoneFromAddressTelphone:(NSString *)str{
    char c=[str characterAtIndex:0];
    if (c=='+') {
        str =[str substringFromIndex:4];
    }
    
    NSString *strForm = @"";
    for (int i =0; i<str.length; i++) {
        unichar c = [str characterAtIndex:i];
        if (c=='-') {
            
        }else{
            strForm = [strForm stringByAppendingFormat:@"%c",c];
        }
    }
    return strForm;
}

//加上分区头标
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _titleArr[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSArray *arr=[sectionTitleArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:arr];
    //其他
    [mutArr addObject:@"#"];
    return mutArr;
}



- (BOOL)programmaticallyCreatePersonWithIcon:(UIImage *)img withFirstName:(NSString *)firstName withLastName:(NSString *)lastName withPhone:(NSString *)phoneNumber withCompany:(NSString *)company withJob:(NSString *)job withEmail:(NSString *)email withAddress:(NSString *)address{
    ABRecordRef newPersonRecord=ABPersonCreate();
    CFErrorRef error=NULL;
    if (img!=nil) {
        
        NSData *imageData=UIImagePNGRepresentation(img);
        ABPersonSetImageData(newPersonRecord, (__bridge CFDataRef)(imageData), &error);
    }
    
    
    if (firstName.length!=0) {
        ABRecordSetValue(newPersonRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName), &error);
    }
    if (lastName.length!=0) {
        ABRecordSetValue(newPersonRecord, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName), &error);
    }
    if (company.length!=0) {
        ABRecordSetValue(newPersonRecord, kABPersonOrganizationProperty, (__bridge CFTypeRef)(company), &error);
    }
    if (job.length!=0) {
        ABRecordSetValue(newPersonRecord, kABPersonJobTitleProperty, (__bridge CFTypeRef)(job), &error);
    }
    if (phoneNumber.length!=0) {
        ABMutableMultiValueRef multiPhoneRef=ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiPhoneRef, (__bridge CFTypeRef)(phoneNumber), kABPersonPhoneMainLabel, NULL);
        //    ABMultiValueAddValueAndLabel(multiPhoneRef, @"34111164633", kABPersonPhoneMobileLabel, NULL);
        //    ABMultiValueAddValueAndLabel(multiPhoneRef, @"322222264633", kABPersonPhoneIPhoneLabel, NULL);
        ABRecordSetValue(newPersonRecord, kABPersonPhoneProperty, multiPhoneRef, nil);
        CFRelease(multiPhoneRef);
    }
    if (email.length!=0) {
        ABMutableMultiValueRef multiEmailref=ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiEmailref,(__bridge CFTypeRef)(email),kABWorkLabel,NULL);
        ABRecordSetValue(newPersonRecord, kABPersonEmailProperty, multiEmailref, &error);
        CFRelease(multiEmailref);
    }
   
    if (address.length!=0) {
        ABMutableMultiValueRef multiAddressRef=ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
        NSMutableDictionary *addressDictionary=[[NSMutableDictionary alloc]init];
        [addressDictionary setObject:address forKey:(NSString *)kABPersonAddressCountryKey];
        //    [addressDictionary setObject:@"Delaware" forKey:(NSString *)kABPersonAddressCityKey];
        //    [addressDictionary setObject:@"MD" forKey:(NSString *)kABPersonAddressStateKey];
        //    [addressDictionary setObject:@"1993" forKey:(NSString *)kABPersonAddressZIPKey];
        ABMultiValueAddValueAndLabel(multiAddressRef, CFBridgingRetain(addressDictionary), kABWorkLabel, NULL);
        ABRecordSetValue(newPersonRecord, kABPersonAddressProperty, multiAddressRef, &error);
        CFRelease(multiAddressRef);
    }
    
    
    
    
    ABAddressBookAddRecord(addressBookRef, newPersonRecord, &error);
    ABAddressBookSave(addressBookRef, &error);
    if (error !=NULL) {
        return NO;
    }

    [self loadPerson];

    return YES;
}

- (void)addNewContactPerson:(id)sender{
    //[self programmaticallyCreatePerson];
    LCAddNewContactPersonViewController *addPersonVC=[[LCAddNewContactPersonViewController alloc]init];
    addPersonVC.startPoint=CGPointMake(WINDOWS.width-30, 30);
    addPersonVC.bubbleColor=[UIColor lightGrayColor];
    addPersonVC.myBlock=^(UIImage *icon,NSString *firstName,NSString *lastname,NSString *phone,NSString *company,NSString *job,NSString *email,NSString *address){
    
        [self programmaticallyCreatePersonWithIcon:icon withFirstName:firstName withLastName:lastname withPhone:phone withCompany:company withJob:job withEmail:email withAddress:address];
    };
    
    [self presentViewController:addPersonVC animated:YES completion:nil];
    
    
    
}
@end
