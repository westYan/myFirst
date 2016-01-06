//
//  ZLManager.h
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

@import Foundation;
@import CoreLocation;
#import "ZLCondition.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ZLManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) ZLCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyF;
@property (nonatomic, strong, readonly) NSArray *dailyF;
@property (nonatomic, strong, readwrite) NSString *cityName;

+ (instancetype)sharedManager;

- (void)findCurrentLocation;

@end
