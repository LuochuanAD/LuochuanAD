//
//  ICFTimelineViewController.m
//  SocialNetworking
//
//  Created by Kyle Richter on 12/4/12.
//  Copyright (c) 2012 Kyle Richter. All rights reserved.
//

#import "ICFTimelineViewController.h"
#import "ICFTimeLineCell.h"

@interface ICFTimelineViewController ()

@end

@implementation ICFTimelineViewController

@synthesize timelineData;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [timelineTableView registerNib:[UINib nibWithNibName:@"ICFTimeLineCell" bundle:nil] forCellReuseIdentifier:@"ICFTimeLineCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [self.timelineData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL facebook = NO;
    NSDictionary *timelineObject = [self.timelineData objectAtIndex: indexPath.row];
        
    if([timelineObject objectForKey: @"privacy" ] != nil)
    {
        facebook = YES;
    }

    static NSString *CellIdentifier = @"ICFTimeLineCell";
    
    ICFTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ICFTimeLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(facebook)
    {
        NSString *textToDisplay = nil;
        
        if([timelineObject objectForKey: @"message"] != nil)
        {
            textToDisplay = [timelineObject objectForKey: @"message"];
        }
        
        else if([timelineObject objectForKey: @"story"] != nil)
        {
            textToDisplay = [timelineObject objectForKey: @"story"];
        }
        
        else if([timelineObject objectForKey: @"description"] != nil)
        {
            textToDisplay = [timelineObject objectForKey: @"description"];
        }
        
        else
        {
            textToDisplay = @"Unable to determine a text message to display";
        }
        
        
        cell.timelineTextLabel.text = textToDisplay;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSString *URLString = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", [[timelineObject objectForKey: @"from"] objectForKey:@"id"]];
            
            if(URLString != nil)
            {
                NSURL *url = [[NSURL alloc] initWithString: URLString];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: url];
                UIImage *image = [[UIImage alloc] initWithData: imageData];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.avatarImageView.image = image;
                });
                
            }
        });

    }
    
    else
    {    
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

            NSString *URLString = [[timelineObject objectForKey: @"user"] objectForKey: @"profile_image_url"];
            
            if(URLString != nil)
            {
                NSURL *url = [[NSURL alloc] initWithString: URLString];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: url];
                UIImage *image = [[UIImage alloc] initWithData: imageData];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.avatarImageView.image = image;
                });
                
            }
        });

        cell.timelineTextLabel.text = [timelineObject objectForKey: @"text"];
    }
        
    return cell;
}

- (IBAction)dismiss:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
