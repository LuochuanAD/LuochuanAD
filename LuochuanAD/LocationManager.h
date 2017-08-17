//
//  LocationManager.h

//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic) CLLocationAccuracy locationAccuracy;

@property (nonatomic) NSMutableDictionary *locationDictionary;
@property (nonatomic) NSMutableArray *locationArray;
@property (nonatomic) BOOL resume;

+ (LocationManager*)sharedInstance;
- (void)startMonitoringLocation;
- (void)restartMonitoringLocation;

- (void)saveResumeLocationToPList;
- (void)saveLocationToPList:(BOOL)resume;
- (void)saveApplicationStatusToPList:(NSString*)applicationStatus;
@end
