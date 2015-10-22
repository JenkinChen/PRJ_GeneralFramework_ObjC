//
//  BaseViewCtrl+Location.m
//  SeekLeather
//
//  Created by 256app on 15/10/21.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl+Location.h"
#import <objc/runtime.h>

@interface BaseViewCtrl ()


@property (nonatomic, copy) LocationSuccess locationSuccess;

@property (nonatomic, copy) LocationFailure locationFailure;

@end

@implementation BaseViewCtrl (Location)

- (void)locationSueeces:(LocationSuccess)locationSuccess failure:(LocationFailure)locationFailure
{
    self.locationSuccess = locationSuccess;
    self.locationFailure = locationFailure;
    
    if ([CLLocationManager locationServicesEnabled]) {//定位服务已开启
        
        if (!self.locationManager) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.distanceFilter = 100.f;
            [self.locationManager startUpdatingLocation];
            
            //ios8
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        }
        else {
            [self.locationManager startUpdatingLocation];
        }
        
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"定位服务当前可能尚未打开，请设置打开"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    CLLocation * currentLocation = newLocation;
    [self.locationManager stopUpdatingLocation];
    
    [self reverseGeocodeLocation:currentLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    CLLocation * currentLocation = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
    
    [self reverseGeocodeLocation:currentLocation];
}

- (void)reverseGeocodeLocation:(CLLocation *)currentLocation
{
    //地理反编码
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        if (self.locationSuccess) {
            self.locationSuccess(placemark, currentLocation);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.locationFailure) {
        self.locationFailure(error);
    }
    [self.locationManager stopUpdatingLocation];
    NSLog(@"定位error==%@", error);
}

#pragma mark - Private
- (LocationSuccess)locationSuccess
{
    return objc_getAssociatedObject(self, @selector(locationSuccess));
}

- (void)setLocationSuccess:(LocationSuccess)locationSuccess
{
    objc_setAssociatedObject(self, @selector(locationSuccess), locationSuccess, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LocationFailure)locationFailure
{
    return objc_getAssociatedObject(self, @selector(locationFailure));
}

- (void)setLocationFailure:(LocationFailure)locationFailure
{
    objc_setAssociatedObject(self, @selector(locationFailure), locationFailure, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLLocationManager *)locationManager
{
    return objc_getAssociatedObject(self, @selector(locationManager));
}

- (void)setLocationManager:(CLLocationManager *)locationManager
{
    objc_setAssociatedObject(self, @selector(locationManager), locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
