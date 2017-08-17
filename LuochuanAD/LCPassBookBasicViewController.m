//
//  LCPassBookBasicViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//只支持iPhone和ipodtouch

#import "LCPassBookBasicViewController.h"

@interface LCPassBookBasicViewController ()

@end

@implementation LCPassBookBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passLibrary=[[PKPassLibrary alloc]init];
    [self refreshPassStatusView];
    
}

- (IBAction)addPassBtnClicked:(id)sender {
    NSString *passPath =
    [[NSBundle mainBundle] pathForResource:self.passFileName
                                    ofType:@"pkpass"];
    
    NSData *passData = [NSData dataWithContentsOfFile:passPath];
    
    NSError *passError = nil;
    PKPass *newPass = [[PKPass alloc]
                       initWithData:passData error:&passError];
    
    
    if (!passError && ![self.passLibrary containsPass:newPass])
    {
        PKAddPassesViewController *newPassVC =
        [[PKAddPassesViewController alloc] initWithPass:newPass];
        
        [newPassVC setDelegate:self];
        
        [self presentViewController:newPassVC
                           animated:YES
                         completion:^(){}];
        
    }
    else
    {
        
        NSString *passUpdateMessage = @"";
        
        if (passError) {
            
            passUpdateMessage =
            [NSString stringWithFormat:@"Pass Error: %@",
             [passError localizedDescription]];
            
        } else {
            passUpdateMessage = [NSString stringWithFormat:
                                 @"Your %@ has already been added.",
                                 self.passTypeName];
        }
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Pass Not Added"
                                   message:passUpdateMessage
                                  delegate:nil
                         cancelButtonTitle:@"Dismiss"
                         otherButtonTitles:nil];
        [alert show];
    }

    
    
    
    
}

- (IBAction)updatePassBtnClicked:(id)sender {
    NSString *passName =
    [NSString stringWithFormat:@"%@-Update",self.passFileName];
    
    NSString *passPath =
    [[NSBundle mainBundle] pathForResource:passName ofType:@"pkpass"];
    
    NSData *passData = [NSData dataWithContentsOfFile:passPath];
    
    NSError *passError = nil;
    
    PKPass *updatedPass = [[PKPass alloc] initWithData:passData
                                                 error:&passError];
    
    if (!passError && [self.passLibrary containsPass:updatedPass])
    {
        
        BOOL updated = [self.passLibrary
                        replacePassWithPass:updatedPass];
        
        NSString *passUpdateMessage = @"";
        NSString *passAlertTitle = @"";
        
        if (updated)
        {
            passUpdateMessage = [NSString stringWithFormat:
                                 @"Your %@ has been updated.",self.passTypeName];
            
            passAlertTitle = @"Pass Updated";
        }
        else
        {
            passUpdateMessage = [NSString stringWithFormat:
                                 @"Your %@ could not be updated.",self.passTypeName];
            
            passAlertTitle = @"Pass Not Updated";
        }
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:passAlertTitle
                                   message:passUpdateMessage
                                  delegate:nil
                         cancelButtonTitle:@"Dismiss"
                         otherButtonTitles:nil];
        [alert show];
    }

    
}

- (IBAction)showPassBtnClicked:(id)sender {
//    PKPass *currentPass=[self.passLibrary passWithPassTypeIdentifier:self.passIdentifier serialNumber:self.passSerialNum];
    
    NSString *passPath =
    [[NSBundle mainBundle] pathForResource:self.passFileName
                                    ofType:@"pkpass"];
    NSData *passData = [NSData dataWithContentsOfFile:passPath];
    
    
    PKPass *currentPass = [[PKPass alloc]
                       initWithData:passData error:nil];
    
    if (currentPass) {
        [[UIApplication sharedApplication]openURL:[currentPass passURL]];
    }
    
}

- (IBAction)deletePassBtnClicked:(id)sender {
//    PKPass *currentPass=[self.passLibrary passWithPassTypeIdentifier:self.passIdentifier serialNumber:self.passSerialNum];
    
    NSString *passPath =
    [[NSBundle mainBundle] pathForResource:self.passFileName
                                    ofType:@"pkpass"];
    NSData *passData = [NSData dataWithContentsOfFile:passPath];
    
    
    PKPass *currentPass = [[PKPass alloc]
                           initWithData:passData error:nil];

    
    if (currentPass) {
        [self.passLibrary removePass:currentPass];
        [self refreshPassStatusView];
        NSString *passUpdateMessage=[NSString stringWithFormat:@"Your %@ has been removed",self.passTypeName];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pass Removed" message:passUpdateMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
}
- (void)refreshPassStatusView{
    if (![PKPassLibrary isPassLibraryAvailable])
    {
        
        [self.passInLable setText:@"Pass Library not available."];
        
        [self.numberPassLable setText:@""];
        [self.addButton setHidden:YES];
        [self.updateButton setHidden:YES];
        [self.showButton setHidden:YES];
        [self.deleteButton setHidden:YES];
        return;
    }
    
    NSArray *passes = [self.passLibrary passes];
    
    NSString *numPassesString =
    [NSString stringWithFormat:
     @"There are %lu passes in Passbook.",(unsigned long)[passes count]];
    
    [self.numberPassLable setText:numPassesString];
    /**
    PKPass *currentBoardingPass =
    [self.passLibrary passWithPassTypeIdentifier:self.passIdentifier
                                    serialNumber:self.passSerialNum];
    
    if (currentBoardingPass)
    {
        [self.passInLable setText:
         [NSString stringWithFormat:@"%@ is in Passbook",
          self.passTypeName]];
        
        [self.updateButton setHidden:NO];
        [self.showButton setHidden:NO];
        [self.deleteButton setHidden:NO];
    } else
    {
        [self.passInLable setText:
         [NSString stringWithFormat:@"%@ is not in Passbook",
          self.passTypeName]];
        
        [self.updateButton setHidden:YES];
        [self.showButton setHidden:YES];
        [self.deleteButton setHidden:YES];
    }
    */
    
    NSString *passPath =
    [[NSBundle mainBundle] pathForResource:self.passFileName
                                    ofType:@"pkpass"];
    NSData *passData = [NSData dataWithContentsOfFile:passPath];
    
    
    PKPass *newPass = [[PKPass alloc]
                       initWithData:passData error:nil];
    
    if ([self.passLibrary containsPass:newPass])
    {
        [self.passInLable setText:
         [NSString stringWithFormat:@"%@ is in Passbook",
          self.passTypeName]];
        
        [self.updateButton setHidden:NO];
        [self.showButton setHidden:NO];
        [self.deleteButton setHidden:NO];
    } else
    {
        [self.passInLable setText:
         [NSString stringWithFormat:@"%@ is not in Passbook",
          self.passTypeName]];
        
        [self.updateButton setHidden:YES];
        [self.showButton setHidden:YES];
        [self.deleteButton setHidden:YES];
    }
}
- (void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:^{
        [self refreshPassStatusView];
    }];
}

@end
