//
//  FrontTableViewController.h
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "WeatherHTTPClient.h"


@interface FrontTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, WeatherHTTPClientDelegate>

@property (nonatomic, strong) City *city;
@property (nonatomic, strong) WeatherHTTPClient *client;

@property (nonatomic, strong) NSDictionary * weatherData;
@property (nonatomic, strong) NSMutableArray * forcastWeatherArray;

@end
