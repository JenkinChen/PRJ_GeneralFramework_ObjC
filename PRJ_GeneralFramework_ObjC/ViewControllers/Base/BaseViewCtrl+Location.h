//
//  BaseViewCtrl+Location.h
//  SeekLeather
//
//  Created by 256app on 15/10/21.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl.h"
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationSuccess)(CLPlacemark *placemark, CLLocation *currentLocation);

typedef void(^LocationFailure)(NSError *error);

@interface BaseViewCtrl (Location) <CLLocationManagerDelegate>

@property (nonatomic, strong, readonly) CLLocationManager *locationManager;

- (void)locationSueeces:(LocationSuccess)locationSuccess failure:(LocationFailure)locationFailure;

@end
