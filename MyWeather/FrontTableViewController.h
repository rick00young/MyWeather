//
//  FrontTableViewController.h
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface FrontTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) City *city;

@end
