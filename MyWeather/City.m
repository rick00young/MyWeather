//
//  City.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "City.h"

@implementation City

-(NSString *)description{
    return [NSString stringWithFormat:@"cityNmae = %@; weatherCode = %@", self.cityName, self.weatherCode ];
}

@end
