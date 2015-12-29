//
//  ZLData.h
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>
@import Foundation;

@interface ZLData : NSObject

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;
- (RACSignal *)fetchCurrentConditionForLocation:(CLLocationCoordinate2D)coordinate;
- (RACSignal *)fetchHourFForLocation:(CLLocationCoordinate2D)coordinate;
- (RACSignal *)fetchDailyFForLocation:(CLLocationCoordinate2D)coordinate;

@end
