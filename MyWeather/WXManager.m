//
//  WXManager.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "WXManager.h"

@implementation WXManager

+(instancetype)sharedManager{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

-(id)init{
    if (self = [super init]) {
        self.client = [[Client alloc] init];
        self.weatherHTTPClient = [[WeatherHTTPClient alloc] init];
    }
    
    return self;
}

-(NSDictionary *)getProvinces{
    return [self.client getAllCities];
    
}

//------------------
-(void)getCurrentWeather:(NSString *)weatherCode{
    
    return [self.weatherHTTPClient getCurrentWeather:weatherCode];
    
}


-(void)findCurrentLocation{

}

@end
