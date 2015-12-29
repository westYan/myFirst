//
//  ZLCondition.h
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ZLCondition : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong) NSDate   *myDate;
@property (nonatomic ,strong) NSNumber *humidity;
@property (nonatomic ,strong) NSNumber *temperature;
@property (nonatomic ,strong) NSNumber *tempHigh;
@property (nonatomic ,strong) NSNumber *tempLow;
@property (nonatomic ,strong) NSNumber *windBearing;
@property (nonatomic ,strong) NSNumber *windSpeed;
@property (nonatomic ,strong) NSString *locationName;
@property (nonatomic ,strong) NSDate   *sunrise;
@property (nonatomic ,strong) NSDate   *sunset;
@property (nonatomic ,strong) NSString *conditionDescription;
@property (nonatomic ,strong) NSString *condition;
@property (nonatomic ,strong) NSString *icon;


- (NSString *)imageName;
@end
