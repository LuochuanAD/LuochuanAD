//
//  LCBackGroundtaskViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/19.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCBackGroundtaskViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface LCBackGroundtaskViewController ()

@end

@implementation LCBackGroundtaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *playerInitError=nil;
    NSString *audioPath=[[NSBundle mainBundle]pathForResource:@"background_audio" ofType:@"mp3"];
    NSURL *audioURL=[NSURL fileURLWithPath:audioPath];
    self.audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:audioURL error:&playerInitError];
    
    
    
    AVAudioSession *session=[AVAudioSession sharedInstance];
    NSError *activeError=nil;
    if (![session setActive:YES error:&activeError]) {
        NSLog(@"==Faild to setActive audio session!");
    }
    NSError *categoryError =nil;
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&categoryError]) {
        NSLog(@"==Failed to setAudio category!");
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)playBackGroundMusicEvent:(id)sender {
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
        [self.playBGMButton setTitle:@"playBackGroundMusic" forState:UIControlStateNormal];
    }else{
        UIImage *lockImage=[UIImage imageNamed:@"book_cover"];
        MPMediaItemArtwork *artwork=[[MPMediaItemArtwork alloc]initWithImage:lockImage];
        NSDictionary *mediaDict=
  @{
    MPMediaItemPropertyTitle:@"BackgroundTask Audio",
    MPMediaItemPropertyMediaType:@(MPMediaTypeAnyAudio),
    MPMediaItemPropertyPlaybackDuration:@(self.audioPlayer.duration),
    MPNowPlayingInfoPropertyPlaybackRate:@1.0,
    MPNowPlayingInfoPropertyElapsedPlaybackTime:@(self.audioPlayer.currentTime),
    MPMediaItemPropertyAlbumArtist:@"this is me",
    MPMediaItemPropertyArtwork:artwork
    };
        
        [self.audioPlayer play];
        [self.playBGMButton setTitle:@"Stop Background Music" forState:UIControlStateNormal];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaDict];
        [self becomeFirstResponder];
        [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    }
    
    
    
}

- (IBAction)startBackGroundTaskEvent:(id)sender {
    UIDevice *device=[UIDevice currentDevice];
    if (![device isMultitaskingSupported]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备不支持多任务后台处理" delegate:nil cancelButtonTitle:@"我已知道" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self.startBGTButton setEnabled:NO];
    [self.startBGTButton setTitle:@"后台任务正在处理中" forState:UIControlStateNormal];
    dispatch_queue_t backGround=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backGround, ^{
        [self performBackgroundTask];
    });
    
    
    
}
- (void)performBackgroundTask{
    __block NSInteger counter=0;
    __block UIBackgroundTaskIdentifier bTask=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background Expiration Handler called.");
        NSLog(@"Counter is: %ld, task ID is :%lu.",(long)counter,(unsigned long)bTask);
        
        [[UIApplication sharedApplication] endBackgroundTask:bTask];
        bTask=UIBackgroundTaskInvalid;
        
    }];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSInteger startCounter=[userDefaults integerForKey:@"lastCounter"];
    NSInteger twentyMins=20*60;
    NSLog(@"BackGround task starting,task ID is %lu.",(unsigned long)bTask);
    for (counter =startCounter; counter<=twentyMins; counter++) {
        [NSThread sleepForTimeInterval:1];
        [userDefaults setInteger:counter forKey:@"lastCounter"];
        [userDefaults synchronize];
        NSTimeInterval remainingTime=[[UIApplication sharedApplication] backgroundTimeRemaining];
        if (remainingTime == DBL_MAX) {
            NSLog(@"Background Processed %ld. Still in foreground.",
                  (long)counter);
        } else {
            NSLog(@"Background Processed %ld. Time remaining is: %f",
                  (long)counter,remainingTime);
        }
        
    }
    NSLog(@"Background Completed tasks");
    [userDefaults setInteger:0 forKey:@"lastCounter"];
    [userDefaults synchronize];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.startBGTButton setEnabled:YES];
        [self.startBGTButton setTitle:@"StartBackGroundTask" forState:UIControlStateNormal];
    });
    [[UIApplication sharedApplication] endBackgroundTask:bTask];
    bTask=UIBackgroundTaskInvalid;
}
@end
