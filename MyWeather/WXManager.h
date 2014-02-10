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


@interface WXManager : NSObject

+(instancetype) sharedManager;

@property (nonatomic, strong,readonly) CLLocation *currentLocation;


-(void) findCurrentLocation;
-(NSDictionary *)getProvinces;

@end
