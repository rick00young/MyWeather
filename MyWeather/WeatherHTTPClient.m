//
//  WeatherHTTPClient.m
//  MyWeather
//
//  Created by rick on 14-2-11.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "WeatherHTTPClient.h"
#import <AFNetworking/AFNetworking.h>


#define WEATHERURL @"http://www.weather.com.cn/data/cityinfo/%@.html"

#define FORECASTWEATHERURL @"http://m.weather.com.cn/data/%@.html"

@implementation WeatherHTTPClient



-(void)getCurrentWeather:(NSString *)weatherCode{
    // 1
    NSString *weatherUrl = [NSString stringWithFormat:WEATHERURL,weatherCode];
    
    NSURL *url = [NSURL URLWithString:weatherUrl];
    
    [self fetchJSONData:url];
    
}

-(void)getForecastWeather:(NSString *)weatherCode{
    
    NSString *forcastUrl = [NSString stringWithFormat:FORECASTWEATHERURL, weatherCode];
    NSURL *url = [NSURL URLWithString:forcastUrl];
    
    
    [self fetchJSONData:url];
}

-(void)fetchJSONData:(NSURL *)url{

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     // 3
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]) {
                                                            [self.delegate weatherHTTPClient:self didUpdateWithWeather:JSON];
                                                        }
                                                        
                                                    }
     // 4
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        
                                                        /*
                                                         UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                         message:[NSString stringWithFormat:@"%@",error]
                                                         delegate:nil
                                                         cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                         [av show];
                                                         */
                                                        
                                                        if ([self.delegate respondsToSelector:@selector(weatherHTTPCLient:didFailWithError:)]) {
                                                            [self.delegate weatherHTTPCLient:self didFailWithError:error];
                                                        }
                                                    }];
    
    // 5
    [operation start];
    
}

@end
