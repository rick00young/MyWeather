//
//  Province.h
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *provinceId;

@property (nonatomic, strong) NSMutableArray *cities;

@end
