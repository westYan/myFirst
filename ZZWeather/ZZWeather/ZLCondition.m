//
//  ZLCondition.m
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//
#define MPS_TO_MPH 2.23694f
#import "ZLCondition.h"

@implementation ZLCondition

+ (NSDictionary *)imageMap{
    static NSDictionary *_imageMap = nil;
    if (_imageMap == nil) {
        _imageMap = @{
                      @"01d" : @"weather-clear",
                      @"02d" : @"weather-few",
                      @"03d" : @"weather-few",
                      @"04d" : @"weather-broken",
                      @"09d" : @"weather-shower",
                      @"10d" : @"weather-rain",
                      @"11d" : @"weather-tstorm",
                      @"13d" : @"weather-snow",
                      @"50d" : @"weather-mist",
                      @"01n" : @"weather-moon",
                      @"02n" : @"weather-few-night",
                      @"03n" : @"weather-few-night",
                      @"04n" : @"weather-broken",
                      @"09n" : @"weather-shower",
                      @"10n" : @"weather-rain-night",
                      @"11n" : @"weather-tstorm",
                      @"13n" : @"weather-snow",
                      @"50n" : @"weather-mist",
                      };
        
    }

    return _imageMap;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"myDate": @"dt",
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"conditionDescription": @"weather.description",
             @"condition": @"weather.main",
             @"icon": @"weather.icon",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed"
             };
}

 + (NSValueTransformer *)dateJSONTransformer {
 
 return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
 
 return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
 
 } reverseBlock:^(NSDate *date) {

     return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
 
    }];
 
 }
 
 // 2
 + (NSValueTransformer *)sunriseJSONTransformer {
 return [self dateJSONTransformer];
 }
 
 + (NSValueTransformer *)sunsetJSONTransformer {
 return [self dateJSONTransformer];
 } 



+ (NSValueTransformer *)conditionDescriptionJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *str) {
        return @[str];
    }];
}

+ (NSValueTransformer *)conditionJSONTransformer {
    return [self conditionDescriptionJSONTransformer];
}

+ (NSValueTransformer *)iconJSONTransformer {
    return [self conditionDescriptionJSONTransformer];
}


+ (NSValueTransformer *)windSpeedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        return @(num.floatValue*MPS_TO_MPH);
    } reverseBlock:^(NSNumber *speed) {
        return @(speed.floatValue/MPS_TO_MPH);
    }];
}










- (NSString *)imageName{

    return [ZLCondition imageMap][self.icon];
}
@end
