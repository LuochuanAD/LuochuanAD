//
//  ICFTimelineViewController.h
//  SocialNetworking
//
//  Created by Kyle Richter on 12/4/12.
//  Copyright (c) 2012 Kyle Richter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICFTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    
    IBOutlet UITableView *timelineTableView;
    NSArray *timelineData;
}

@property(nonatomic, strong) NSArray *timelineData;

- (IBAction)dismiss:(id)sender;


@end
