//
//  LCTwitterAndFaceBookSharedViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/18.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCTwitterAndFaceBookSharedViewController.h"
#import "SuPhotoPicker.h"
#import "ICFTimelineViewController.h"
typedef  NS_ENUM(NSUInteger,ServiceType){
    ServiceTypeFaceBook =0,
    ServiceTypeTwitter =1
};

@interface LCTwitterAndFaceBookSharedViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *multImagesArray;
    NSMutableArray *multUrlArray;
    ACAccount *facebookAccount;
}
@property (nonatomic, assign)ServiceType serviceType;
@end

@implementation LCTwitterAndFaceBookSharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    multUrlArray =[[NSMutableArray alloc]init];
    self.title=@"国内手机一张图片一个连接";
    //facebookAPPID
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *facebookAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary *options = @{
                              ACFacebookAudienceKey : ACFacebookAudienceEveryone,
                              ACFacebookAppIdKey : @"",
                              ACFacebookPermissionsKey : @[@"email"]};
    
    [accountStore requestAccessToAccountsWithType:facebookAccountType options:options completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSLog(@"Basic access granted");
         }
         
         else
         {
             NSLog(@"Basic access denied");
         }
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}

- (IBAction)sharedToFaceBook:(UIButton *)sender {
    self.serviceType=ServiceTypeFaceBook;
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"FaceBook" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"系统",@"自定义界面",@"timeLine", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)sharedToTwitter:(UIButton *)sender {
    self.serviceType=ServiceTypeTwitter;
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Twitter" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"系统",@"自定义界面",@"timeLine", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)selectImage:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    SuPhotoPicker * picker = [[SuPhotoPicker alloc]init];
    picker.selectedCount = 9;
    picker.preViewCount = 20;
    [picker showInSender:self.tabBarController handle:^(NSArray<UIImage *> *photos) {
        [weakSelf showSelectedPhotos:photos];
    }];
}

- (IBAction)clearAllImages:(UIButton *)sender {
    [multImagesArray removeAllObjects];
    [self.clearAllImageBtn setTitle:@"清除照片" forState:UIControlStateNormal];
}

- (IBAction)addUrl:(UIButton *)sender {
    if (self.urlTextFiled.text.length!=0) {
        [multUrlArray addObject:self.urlTextFiled.text];
        self.urlTextView.text=[self.urlTextView.text stringByAppendingString:[NSString stringWithFormat:@"     %@",self.urlTextFiled.text]];
        [self.clearAllUrlBtn setTitle:[NSString stringWithFormat:@"清除链接:%lu",multUrlArray.count] forState:UIControlStateNormal];
    }
}

- (IBAction)clearAllUrl:(UIButton *)sender {
    [multUrlArray removeAllObjects];
    self.urlTextView.text=@"";
    [self.clearAllUrlBtn setTitle:@"清除链接" forState:UIControlStateNormal];
}
- (void)showSelectedPhotos:(NSArray *)imgs {

    multImagesArray=[NSMutableArray arrayWithArray:imgs];
    [self.clearAllImageBtn setTitle:[NSString stringWithFormat:@"清除照片:%lu",(unsigned long)multImagesArray.count] forState:UIControlStateNormal];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.serviceType==ServiceTypeTwitter) {
        if (buttonIndex==0) {
            [self sharedToSystemForTwitter];
        }else if(buttonIndex==1){
            [self sharedToCustomForTwitter];
        }else{
            [self sharedToTimeLineForTwitter];
        }
    }else if (self.serviceType==ServiceTypeFaceBook){
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *facebookAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        NSDictionary *options = nil;

        
        if (buttonIndex==0) {
            [self sharedToSystemForFaceBook];
        }else if(buttonIndex==1){
            options = @{
                        ACFacebookAudienceKey : ACFacebookAudienceEveryone,
                        ACFacebookAppIdKey : @"363120920441086",
                        ACFacebookPermissionsKey : @[@"publish_stream"]};
            
            [accountStore requestAccessToAccountsWithType:facebookAccountType options:options completion:^(BOOL granted, NSError *error)
             {
                 if (granted)
                 {
                     NSArray *accounts = [accountStore accountsWithAccountType:facebookAccountType];
                     facebookAccount = [accounts lastObject];
                     
                     [self performSelectorOnMainThread:@selector(sharedToCustomForFaceBook) withObject:nil waitUntilDone:NO];
                 }
                 
                 else
                 {
                     [self performSelectorOnMainThread:@selector(faceBookError:) withObject:error waitUntilDone:NO];
                 }
             }];
        }else{
            options = @{
                        ACFacebookAudienceKey : ACFacebookAudienceEveryone,
                        ACFacebookAppIdKey : @"363120920441086",
                        ACFacebookPermissionsKey : @[@"read_stream"]};
            
            [accountStore requestAccessToAccountsWithType:facebookAccountType options:options completion:^(BOOL granted, NSError *error)
             {
                 if (granted)
                 {
                     NSArray *accounts = [accountStore accountsWithAccountType:facebookAccountType];
                     facebookAccount = [accounts lastObject];
                     
                     [self performSelectorOnMainThread:@selector(sharedToTimeLineForFaceBook) withObject:nil waitUntilDone:NO];
                 }
                 
                 else
                 {
                     [self performSelectorOnMainThread:@selector(faceBookError:) withObject:error waitUntilDone:NO];
                 }
             }];
        

        }
    }
}
- (void)sharedToSystemForTwitter{
    if ([SLComposeViewController  isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *controller=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        SLComposeViewControllerCompletionHandler myBlock=^(SLComposeViewControllerResult result){
            if (result==SLComposeViewControllerResultCancelled) {
                NSLog(@"canceled");
            }else{
                NSLog(@"done");
                
            }
            [controller dismissViewControllerAnimated:YES completion:nil];
        };
        controller.completionHandler=myBlock;
        [controller setInitialText:self.changeCharTextView.text];
        if (multImagesArray.count>0) {
            for (int i=0; i<multImagesArray.count; i++) {
                [controller addImage:multImagesArray[i]];
            }
        }
        
        if (multUrlArray.count>0) {
            for (int i=0; i<multUrlArray.count; i++) {
                [controller addURL:[NSURL URLWithString:multUrlArray[i]]];
            }
        }
        
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"当前设备不支持分享Twitter" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
        [alert show];
    }


}
- (void)sharedToSystemForFaceBook{
    if ([SLComposeViewController  isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        SLComposeViewControllerCompletionHandler myBlock=^(SLComposeViewControllerResult result){
            if (result==SLComposeViewControllerResultCancelled) {
                NSLog(@"canceled");
            }else{
                NSLog(@"done");
                
            }
            [controller dismissViewControllerAnimated:YES completion:nil];
        };
        controller.completionHandler=myBlock;
        [controller setInitialText:self.changeCharTextView.text];
        if (multImagesArray.count>0) {
            for (int i=0; i<multImagesArray.count; i++) {
                [controller addImage:multImagesArray[i]];
            }
        }
        if (multUrlArray.count>0) {
            for (int i=0; i<multUrlArray.count; i++) {
                [controller addURL:[NSURL URLWithString:multUrlArray[i]]];
            }
        }
        
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"当前设备不支持分享Facebook" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
        [alert show];
    }

}
- (void)sharedToCustomForTwitter{
    ACAccountStore *account=[[ACAccountStore alloc]init];
    ACAccountType *accountType=[account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if(error != nil)
        {
            [self performSelectorOnMainThread:@selector(reportSuccessOrError:) withObject:[error localizedDescription] waitUntilDone:NO];
            
        }
        if (granted==YES) {
            NSArray *arrayOfAccounds=[account accountsWithAccountType:accountType];
            if (arrayOfAccounds.count>0) {
                ACAccount *twitterAccount=[arrayOfAccounds lastObject];
                NSURL *requestUrl=nil;
                if (multImagesArray.count>0) {
                    requestUrl=[NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"];
                }else{
                    requestUrl=[NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
                }
                SLRequest *customRequest=[SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:requestUrl parameters:nil];
                if (self.changeCharTextView.text.length>0) {
                    [customRequest addMultipartData:[self.changeCharTextView.text dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data" filename:nil];
                }
                if (multImagesArray.count>0) {
                    NSData *imageData=UIImageJPEGRepresentation(multImagesArray[0], 1.0);
                    [customRequest addMultipartData:imageData withName:@"media" type:@"image/jpg" filename:@"Image.jpg"];
                }
                customRequest.account=twitterAccount;
                [customRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    if (error!=nil) {
                        
                        [self performSelectorOnMainThread:@selector(reportSuccessOrError:) withObject:[error localizedDescription] waitUntilDone:NO];
                    }
                    if ([urlResponse statusCode]==200) {
                        [self performSelectorOnMainThread:@selector(reportSuccessOrError:) withObject:@"Your message has been posted to Twitter" waitUntilDone:NO];
                    }
                }];
                
            }
        }else{
            NSLog(@"授权失败");
        }
        
        
    }];


}
-(void)reportSuccessOrError:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    
    
}
- (void)sharedToTimeLineForTwitter{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if(error != nil)
         {
             [self performSelectorOnMainThread:@selector(reportSuccessOrError:) withObject:[error localizedDescription] waitUntilDone:NO];
         }
         
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/home_timeline.json"];
                 
                 NSDictionary *options = @{
                                           @"count" : @"20",
                                           @"include_entities" : @"1"};
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:options];
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      if(error!= nil)
                      {
                          [self reportSuccessOrError: [error localizedDescription]];
                          
                      }else{
                          NSArray *arr=(NSArray *)[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                         
                      [self performSelectorOnMainThread:@selector(presentTimeline:) withObject: arr waitUntilDone:NO];
                      
                      }
                      
                      
                      
                  }];
             }
         }
     }];


}
-(void)presentTimeline:(NSArray *)timelineArray;
{
    
    ICFTimelineViewController *timelineVC = [[ICFTimelineViewController alloc] init];
    timelineVC.timelineData = timelineArray;
    [self presentViewController:timelineVC animated:YES completion:nil];
    
}
-(void)sharedToCustomForFaceBook
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:self.changeCharTextView.text forKey:@"message"];
    
    NSURL *feedURL = nil;
    
    if(multImagesArray.count>0)
    {
        feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/photos"];
    }
    
    else
    {
        feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    }
    
    
    SLRequest *feedRequest = [SLRequest
                              requestForServiceType:SLServiceTypeFacebook
                              requestMethod:SLRequestMethodPOST
                              URL:feedURL
                              parameters:parameters];
    
    if(multImagesArray.count>0)
    {
        NSData *imageData = UIImagePNGRepresentation(multImagesArray[0]);
        [feedRequest addMultipartData:imageData withName:@"source" type:@"multipart/form-data" filename:@"Image"];
    }
    
    feedRequest.account = facebookAccount;
    
    [feedRequest performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse, NSError *error)
     {
         
        
         
         if([urlResponse statusCode] == 200)
         {
             [self performSelectorOnMainThread:@selector(reportSuccessOrError:) withObject:@"Your message has been posted to Facebook" waitUntilDone:NO];
             
         }
         
         else if(error != nil)
         {
             [self performSelectorOnMainThread:@selector(faceBookError:) withObject:error waitUntilDone:NO];
         }
         
     }];
}
-(void)faceBookError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}
-(void)sharedToTimeLineForFaceBook
{
    NSURL *feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    
    SLRequest *feedRequest = [SLRequest
                              requestForServiceType:SLServiceTypeFacebook
                              requestMethod:SLRequestMethodGET
                              URL:feedURL
                              parameters:nil];
    
    feedRequest.account = facebookAccount;
    
    [feedRequest performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse, NSError *error)
     {
         if([urlResponse statusCode] == 200)
         {
             
             NSArray *arr=(NSArray *)[[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error] objectForKey:@"data"];
             [self performSelectorOnMainThread:@selector(presentTimeline:) withObject:arr waitUntilDone:NO];
         }
         
         else if(error != nil)
         {
             [self performSelectorOnMainThread:@selector(faceBookError:) withObject:error waitUntilDone:NO];
             
         }
         
     }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSInteger charracterCount=textView.text.length;
    charracterCount -=range.length;
    charracterCount +=text.length;
    if (charracterCount<140) {
        
        self.changeCharlable.text=[NSString stringWithFormat:@"%ld字剩余",(140-charracterCount)];
        
        return YES;
    }
    return NO;
}
@end
