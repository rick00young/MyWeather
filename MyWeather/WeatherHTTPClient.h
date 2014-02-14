//
//  WeatherHTTPClient.h
//  MyWeather
//
//  Created by rick on 14-2-11.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherHTTPClientDelegate;

@interface WeatherHTTPClient : NSObject

@property (weak) id delegate;


-(void)getCurrentWeather:(NSString *)weatherCode;
-(void)getForecastWeather:(NSString *)weatherCode;

@end



@protocol WeatherHTTPClientDelegate

-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(NSDictionary *)weather;
-(void)weatherHTTPCLient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;

@end
