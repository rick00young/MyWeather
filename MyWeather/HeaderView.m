//
//  HeaderView.m
//  MyWeather
//
//  Created by rick on 14-2-11.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        //self.tableView.tableHeaderView = header;
        
    }
    return self;
}

-(void)addTemperatureLabel:(CGRect)frame{
    //bottom left
    self.temperatureLabel = [[UILabel alloc] initWithFrame:frame];
    self.temperatureLabel.backgroundColor = [UIColor clearColor];
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.text = @"0°";
    _temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:80];
    [self addSubview:_temperatureLabel];
}

-(void)addHiloLabel:(CGRect)frame{
    _hiloLabel = [[UILabel alloc] initWithFrame:frame];
    _hiloLabel.backgroundColor = [UIColor clearColor];
    _hiloLabel.textColor = [UIColor whiteColor];
    _hiloLabel.text = @"0° / 0°";
    _hiloLabel.font = _hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    [self addSubview:_hiloLabel];
}

-(void)addCityLabel:(CGRect)frame{
    //top
    _cityLabel = [[UILabel alloc] initWithFrame:frame];
    _cityLabel.backgroundColor = [UIColor clearColor];
    _cityLabel.textColor = [UIColor whiteColor];
    _cityLabel.text = @"Loading";
    _cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_cityLabel];
}

-(void)addConditionsLabel:(CGRect)frame{
    _conditionsLabel = [[UILabel alloc] initWithFrame:frame];
    _conditionsLabel.backgroundColor = [UIColor clearColor];
    _conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    _conditionsLabel.textColor = [UIColor whiteColor];
    [self addSubview:_conditionsLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
