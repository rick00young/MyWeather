//
//  Client.h
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject

-(NSDictionary *)getProvinces;
-(NSDictionary *)getAllCities;
-(NSDictionary *)getCities;
-(NSDictionary *)getWeather;

@property (nonatomic, strong) NSDictionary *allCities;

@property (nonatomic, strong) NSDictionary *weather;

-(void)getCurrentWeather:(NSString *)weatherCode;

@end
