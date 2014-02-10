//
//  Province.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "Province.h"

@implementation Province

-(id)init{
    if (self = [super init]) {
        self.cities = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
