//
//  WXManager.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "WXManager.h"
#include "Client.h"
@implementation WXManager

+(instancetype)sharedManager{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

-(NSDictionary *)getProvinces{
    Client *client = [[Client alloc] init];
    return [client getAllCities];
    
}


-(void)findCurrentLocation{

}

@end
