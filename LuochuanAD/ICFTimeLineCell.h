//
//  ICFTimeLineCell.h
//  SocialNetworking
//
//  Created by Kyle Richter on 12/4/12.
//  Copyright (c) 2012 Kyle Richter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICFTimeLineCell : UITableViewCell
{
    UIImageView *avatarImageView;
    UILabel *timelineTextLabel;
}

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *timelineTextLabel;

@end
