//
//  ZLManager.m
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

#import "ZLManager.h"
#import "ZLData.h"
#import <TSMessages/TSMessage.h>

@interface ZLManager ()
@property (nonatomic, strong, readwrite) ZLCondition *currentCondition;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong, readwrite) NSArray *hourlyF;
@property (nonatomic, strong, readwrite) NSArray *dailyF;


@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) ZLData *data;

@end


@implementation ZLManager

+ (instancetype)sharedManager{

    static id _sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init{

    if (self = [super init]) {
     
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        
        _data = [ZLData new];
        
        
        [[[[RACObserve(self, currentLocation) ignore:nil]
         
         flattenMap:^id(CLLocation *newOne) {
            
            return [RACSignal merge:@[
                                       [self updateCurrentConditions],
                                       [self updateDailyF],
                                       [self updateHourlyF]
                                       ]];
                      }] deliverOn:RACScheduler.mainThreadScheduler]
         subscribeError:^(NSError *error) {
             [TSMessage showNotificationWithTitle:@"error" subtitle:@"这里出错了" type:TSMessageNotificationTypeError];
             NSLog(@"%@",error);
             
            }];
    
    }

    return self;

}

- (void)findCurrentLocation{

    self.isFirstUpdate = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    if (self.isFirstUpdate) {
        
        self.isFirstUpdate = NO;
        
        return;
    }

    CLLocation *location = [locations lastObject];
    
    if (location.horizontalAccuracy > 0) {
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *array, NSError * _Nullable error) {
       
        if (array.count > 0) {
            CLPlacemark *pMark = [array objectAtIndex:0];
            
            NSString *city = pMark.locality;
            if (!city) {
                
                city = pMark.administrativeArea;
            }
            self.cityName = city;
        }
        else if(error == nil &&[array count] == 0){
        
        }else if (error != nil){
        
        }
    
    }];
}

- (RACSignal *)updateCurrentConditions{
    return [[self.data fetchCurrentConditionForLocation:self.currentLocation.coordinate] doNext:^(ZLCondition *condition) {
        self.currentCondition = condition;
    }];
}

- (RACSignal *)updateDailyF{
    return [[self.data fetchDailyFForLocation:self.currentLocation.coordinate] doNext:^(NSArray *conditions) {
        self.dailyF = conditions;
    }];

}
- (RACSignal *)updateHourlyF{
    return [[self.data fetchHourFForLocation:self.currentLocation.coordinate] doNext:^(NSArray *conditions) {
        self.hourlyF = conditions;
    }];
}
@end
