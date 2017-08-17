//
//  LCBackGroundtaskViewController.h
//  LuochuanAD
//
//  Created by care on 17/5/19.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface LCBackGroundtaskViewController : UIViewController
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
- (IBAction)playBackGroundMusicEvent:(id)sender;
- (IBAction)startBackGroundTaskEvent:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playBGMButton;
@property (weak, nonatomic) IBOutlet UIButton *startBGTButton;

@end
