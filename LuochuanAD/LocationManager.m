//
//  LocationManager.m

//

#import "LocationManager.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@implementation LocationManager
+ (LocationManager*)sharedInstance {
    static dispatch_once_t onceToken;
    static LocationManager *sSharedInstance;
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[LocationManager alloc] init];
    });
    return sSharedInstance;
}

-(id)init{
    self =[super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc]init]; 
    }
    return  self;
}


#pragma mark - CLLocationManager

- (void)startMonitoringLocation {
    if (_locationManager){
        [_locationManager stopMonitoringSignificantLocationChanges];
    }
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeOtherNavigation;
    _locationManager.distanceFilter =kCLDistanceFilterNone;
    _locationManager.pausesLocationUpdatesAutomatically =NO;
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        [_locationManager requestAlwaysAuthorization];
        if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0) {
            [_locationManager setAllowsBackgroundLocationUpdates:YES];
        }
    }
    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)restartMonitoringLocation {
    [_locationManager stopMonitoringSignificantLocationChanges];
    _locationManager.delegate = self;
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        [_locationManager requestAlwaysAuthorization];
        if([[UIDevice currentDevice].systemVersion floatValue]>=9.0) {
            [_locationManager setAllowsBackgroundLocationUpdates:YES];
        }
    }
    [_locationManager startMonitoringSignificantLocationChanges];
}


#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    for (int i = 0; i < locations.count; i++) {
        CLLocation * newLocation = [locations objectAtIndex:i];
        self.location = newLocation.coordinate;
        self.locationAccuracy = newLocation.horizontalAccuracy;
    }
    [self saveLocationToPList:_resume];
}



#pragma mark - Plist helper methods

// Below are 3 functions that add location and Application status to PList
// The purpose is to collect location information locally

- (NSString *)applicationState {
    UIApplication* application = [UIApplication sharedApplication];
    NSString * applicationState;
    if([application applicationState]==UIApplicationStateActive){
        applicationState = @"UIApplicationStateActive";
    }else if([application applicationState]==UIApplicationStateBackground){
        applicationState = @"UIApplicationStateBackground";
    }else if([application applicationState]==UIApplicationStateInactive){
        applicationState = @"UIApplicationStateInactive";
    }
    return applicationState;
}

- (void)saveResumeLocationToPList {
    NSString * applicationState = [self applicationState];
    self.locationDictionary = [[NSMutableDictionary alloc]init];
    [_locationDictionary setObject:@"UIApplicationLaunchOptionsLocationKey" forKey:@"Resume"];
    [_locationDictionary setObject:applicationState forKey:@"applicationState"];
    [_locationDictionary setObject:[NSDate date] forKey:@"ClientTime"];
    [self saveToPlist];
}



- (void)saveLocationToPList:(BOOL)resume {
    NSString * applicationState = [self applicationState];
    self.locationDictionary = [[NSMutableDictionary alloc]init];
    [_locationDictionary setObject:[NSNumber numberWithDouble:self.location.latitude]  forKey:@"Latitude"];
    [_locationDictionary setObject:[NSNumber numberWithDouble:self.location.longitude] forKey:@"Longitude"];
    [_locationDictionary setObject:[NSNumber numberWithDouble:self.locationAccuracy] forKey:@"Accuracy"];
    [_locationDictionary setObject:applicationState forKey:@"applicationState"];
    if (resume) {
        [_locationDictionary setObject:@"YES" forKey:@"AddFromResume"];
    } else {
        [_locationDictionary setObject:@"NO" forKey:@"AddFromResume"];
    }
    [_locationDictionary setObject:[NSDate date] forKey:@"ClientTime"];
    
    

    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    NSInteger locationIn =[userDefaults integerForKey:@"locationIn"];
    
    
    if (self.location.latitude>31.173654 &&self.location.latitude<31.213654 && self.location.longitude>121.317253&&self.location.longitude<121.357253) {
        if (locationIn!=1) {
            
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
                [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings){
                    if (settings.authorizationStatus ==UNAuthorizationStatusAuthorized) {
                        [userDefaults setInteger:1 forKey:@"locationIn"];
                        [userDefaults synchronize];
                        UILocalNotification *notification = [[UILocalNotification alloc] init];
                        notification.alertBody =@"欢迎来到上海虹桥国际机场";
                        notification.alertAction = @"";
                        notification.soundName = UILocalNotificationDefaultSoundName;
                        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                        
                    }else{
                        
                    }
                }];
                
            }else if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {// system is iOS8
                UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
                if (UIUserNotificationTypeNone != setting.types) {
                    [userDefaults setInteger:1 forKey:@"locationIn"];
                    [userDefaults synchronize];
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    notification.alertBody =@"欢迎来到上海虹桥国际机场";
                    notification.alertAction = @"";
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                }else{
                    
                }
                
            }else{
                UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
                if(UIRemoteNotificationTypeNone != type){
                    [userDefaults setInteger:1 forKey:@"locationIn"];
                    [userDefaults synchronize];
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    notification.alertBody =@"欢迎来到上海虹桥国际机场";
                    notification.alertAction = @"";
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                }else{
                   
                }
            }
        }
    }else if(self.location.latitude<31.161589&& self.location.latitude>31.121589 && self.location.longitude>121.788982&&self.location.longitude<121.828982){
        if (locationIn!=2) {
            
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
                [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings){
                    if (settings.authorizationStatus ==UNAuthorizationStatusAuthorized) {
                        [userDefaults setInteger:2 forKey:@"locationIn"];
                        [userDefaults synchronize];
                        UILocalNotification *notification = [[UILocalNotification alloc] init];
                        notification.alertBody =@"欢迎来到上海浦东国际机场";
                        notification.alertAction = @"";
                        notification.soundName = UILocalNotificationDefaultSoundName;
                        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                        
                    }else{
                        
                    }
                }];
                
            }else if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {// system is iOS8
                UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
                if (UIUserNotificationTypeNone != setting.types) {
                    [userDefaults setInteger:2 forKey:@"locationIn"];
                    [userDefaults synchronize];
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    notification.alertBody =@"欢迎来到上海浦东国际机场";
                    notification.alertAction = @"";
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

                }else{
                    
                }
                
            }else{
                UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
                if(UIRemoteNotificationTypeNone != type){
                    [userDefaults setInteger:2 forKey:@"locationIn"];
                    [userDefaults synchronize];
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    notification.alertBody =@"欢迎来到上海浦东国际机场";
                    notification.alertAction = @"";
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

                }else{
                    
                }
            }
        }
    }else if(self.location.latitude<32.064400&& self.location.latitude>32.024400 && self.location.longitude>118.772036&&self.location.longitude<118.812036){
        if (locationIn!=3) {
            
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
                [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings){
                    if (settings.authorizationStatus ==UNAuthorizationStatusAuthorized) {
                        [userDefaults setInteger:3 forKey:@"locationIn"];
                        [userDefaults synchronize];
                        UILocalNotification *notification = [[UILocalNotification alloc] init];
                        notification.alertBody =@"欢迎来到大行宫";
                        notification.alertAction = @"";
                        notification.soundName = UILocalNotificationDefaultSoundName;
                        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                        
                    }else{
                        
                    }
                }];
                
            }else if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {// system is iOS8
                UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
                if (UIUserNotificationTypeNone != setting.types) {
                    [userDefaults setInteger:3 forKey:@"locationIn"];
                    [userDefaults synchronize];
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    notification.alertBody =@"欢迎来到大行宫";
                    notification.alertAction = @"";
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                    
                }else{
                    
                }
                
            }else{
                UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
                if(UIRemoteNotificationTypeNone != type){
                    [userDefaults setInteger:3 forKey:@"locationIn"];
                    [userDefaults synchronize];
                    UILocalNotification *notification = [[UILocalNotification alloc] init];
                    notification.alertBody =@"欢迎来到大行宫";
                    notification.alertAction = @"";
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                    
                }else{
                    
                }
            }
        }
    }else{
        [userDefaults setInteger:0 forKey:@"locationIn"];
        [userDefaults synchronize];
    }
    NSLog(@"经纬度:%f,%f",self.location.latitude,self.location.longitude);
    
    [self saveToPlist];
}

- (void)saveApplicationStatusToPList:(NSString*)applicationStatus {
    NSString * applicationState = [self applicationState];
    self.locationDictionary = [[NSMutableDictionary alloc]init];
    [_locationDictionary setObject:applicationStatus forKey:@"applicationStatus"];
    [_locationDictionary setObject:applicationState forKey:@"applicationState"];
    [_locationDictionary setObject:[NSDate date] forKey:@"ClientTime"];
    [self saveToPlist];
}

- (void)saveToPlist {
    NSString *locationDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *locationPath = [NSString stringWithFormat:@"%@/%@", locationDir, @"LocationArray.plist"];
    NSMutableDictionary *rootDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:locationPath];
    if (!rootDictionary) {
        rootDictionary = [[NSMutableDictionary alloc] init];
        self.locationArray = [[NSMutableArray alloc]init];
    } else {
        self.locationArray = [rootDictionary objectForKey:@"LocationArray"];
    }
    if(_locationDictionary) {
        [_locationArray addObject:_locationDictionary];
        [rootDictionary setObject:_locationArray forKey:@"LocationArray"];
    }
    if (![rootDictionary writeToFile:locationPath atomically:FALSE]) {
        NSLog(@"保存LocationArray.plist失败" );
    }
}


@end
