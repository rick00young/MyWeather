//
//  WXManager.h
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "Client.h"
#import "WeatherHTTPClient.h"


@interface WXManager : NSObject

+(instancetype) sharedManager;

@property (nonatomic, strong,readonly) CLLocation *currentLocation;
@property (nonatomic, strong) Client *client;

@property (nonatomic, strong) WeatherHTTPClient * weatherHTTPClient;


-(void) findCurrentLocation;
-(NSDictionary *)getProvinces;

-(void)getCurrentWeather:(NSString *)weatherCode;

@end
