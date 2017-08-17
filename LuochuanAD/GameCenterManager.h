//
//  GameCenterManager.h
//  LuochuanAD
//
//  Created by care on 17/1/9.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GameCenterManagerDelegate <NSObject>
@optional
- (void)gameCenterLoggedIn:(NSError *)error;
- (void)gameCenterScoreReported:(NSError *)error;
- (void)scoreDataUpdate:(NSArray *)score error:(NSError *)error;

@end

@interface GameCenterManager : NSObject
{
    id <NSObject, GameCenterManagerDelegate> delegate;
}
@property (nonatomic, strong) id <GameCenterManagerDelegate,NSObject> delegate;
+ (GameCenterManager *)sharedManager;


@end
