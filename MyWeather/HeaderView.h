//
//  HeaderView.h
//  MyWeather
//
//  Created by rick on 14-2-11.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *hiloLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *conditionsLabel;


-(void)addTemperatureLabel:(CGRect)frame;
-(void)addHiloLabel:(CGRect)frame;
-(void)addCityLabel:(CGRect)frame;
-(void)addConditionsLabel:(CGRect)frame;
@end
