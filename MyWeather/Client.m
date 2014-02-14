//
//  Client.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "Client.h"
#import <AFNetworking/AFNetworking.h>
#import "Province.h"
#import "City.h"

//static NSString *provinceUrl = @"http://flash.weather.com.cn/wmaps/xml/china.xml";
//static NSString *ciryUrl = @"http://flash.weather.com.cn/wmaps/xml/%@.xml ";
//static NSString *weatherUrl = @"http://www.weather.com.cn/data/cityinfo/%@.html";
//static NSString *forcastUrl = @"http://mobile.weather.com.cn/data/forecast/%@.html";

#define WEATHERURL @"http://www.weather.com.cn/data/cityinfo/%@.html"

@interface Client ()

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableString *outstring;

@end

@implementation Client

-(NSDictionary *)getAllCities{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allCities" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *cities = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (cities != nil &&  error == nil) {
        //NSLog(@"data = %@", cities[@"China"][@"province"]);
        //NSLog(@"count = %d", [cities[@"China"][@"province"] count]);
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        for (int i = 0; i < [cities[@"China"][@"province"] count]; i++) {
            //statements
            NSDictionary *_temp = cities[@"China"][@"province"][i];
            Province *province = [[Province alloc] init];
            province.provinceName = _temp[@"name"];
            province.provinceId = _temp[@"id"];
            
            
            if ([_temp[@"city"] isKindOfClass:[NSDictionary class]]) {
                
                //NSLog(@"==NSDictionary==");
                //NSLog(@"city name = %@", _temp[@"city"][@"name"]);
                
                for (int j = 0; j < [_temp[@"city"][@"county"] count]; j++) {
                    NSDictionary *_city = _temp[@"city"][@"county"][j];
                    //NSLog(@"%@", _city);
                    City *city = [[City alloc] init];
                    city.cityName = _city[@"name"];
                    city.weatherCode = _city[@"weatherCode"];
                    
                    
                    //NSLog(@"%@", _city[@"weatherCode"]);

                    [province.cities addObject:city];
                }
            }else if([_temp[@"city"] isKindOfClass:[NSArray class]]){
                //NSLog(@"id = %@", _temp[@"city"][@"id"]);
                //NSLog(@"===NSArray===");
                for (int j = 0; j < [_temp[@"city"] count]; j++) {
                    NSDictionary *_city = _temp[@"city"][j][@"county"];
                    
                    if ([_city isKindOfClass:[NSArray class]]) {
                        //NSLog(@"count = %d", [_city count]);
                        //NSLog(@"%@", _city);
                        for (int m = 0; m < [_city count]; m++) {
                            //NSLog(@"%@", _city);
                            City *city = [[City alloc] init];
                            city.cityName =    _temp[@"city"][j][@"county"][m][@"name"];
                            city.weatherCode = _temp[@"city"][j][@"county"][m][@"weatherCode"];
                            
                            //NSLog(@"%@", _temp[@"city"][j][@"county"][m][@"weatherCode"]);
                            
                            [province.cities addObject:city];
                        }
                    }
                   
                }
            }
            
            //NSLog(@"province.cities = %@", province.cities);
            
            [dic setObject:province forKey:[NSString stringWithFormat:@"%d", i]];
            
        }
        
        
        return dic;
    }
    
    
    
    
    return nil;
}

-(void)getCurrentWeather:(NSString *)weatherCode{
    // 1
    NSString *weatherUrl = [NSString stringWithFormat:WEATHERURL,weatherCode];
    
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSLog(@"url = %@ , weatherCode = %@", weatherUrl, weatherCode);
    
    // 2
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     // 3
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        //self.weather  = (NSDictionary *)JSON;
                                                        NSLog(@"json = %@", JSON);
                                                        
                                                    }
     // 4
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [av show];
                                                    }];
    
    // 5
    [operation start];
}


-(NSDictionary *)getProvinces{
    
    
    return nil;
}

-(NSDictionary *)getCities{

    return nil;
}

-(NSDictionary *)getWeather{

    
    return nil;
}

@end
