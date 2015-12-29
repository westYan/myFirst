//
//  ZLData.m
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

#import "ZLData.h"
#import "ZLCondition.h"
#import "ZLDailyF.h"

@interface ZLData()

@property (nonatomic ,strong)NSURLSession *urlS;

@end

@implementation ZLData

- (id)init{

    if (self == [super init]) {
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlS = [NSURLSession sessionWithConfiguration:conf];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url{

    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.urlS dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (! jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error]; 
            } 
    
            [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
        
            [dataTask cancel];
      
        }];
    }] doError:^(NSError *error) {
        
        NSLog(@"%@",error);

    }];
}

@end
