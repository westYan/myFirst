//
//  ZLDailyF.m
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

#import "ZLDailyF.h"

@implementation ZLDailyF

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // 1
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    // 2
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    // 3
    return paths;
}

@end
