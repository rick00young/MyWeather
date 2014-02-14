//
//  FrontTableViewController.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "FrontTableViewController.h"
#import "SWRevealViewController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "WXManager.h"
#import "HeaderView.h"
#import "Weather.h"

@interface FrontTableViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat screenHeight;

@property (nonatomic, strong) NSDateFormatter *hourlyFormatter;
@property (nonatomic, strong) NSDateFormatter *dailyFormatter;

@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *hiloLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *conditionsLabel;

@property (nonatomic, strong) HeaderView *headerView;

@end

@implementation FrontTableViewController

-(id)init{
    if (self = [super init]) {
        _hourlyFormatter = [[NSDateFormatter alloc] init];
        _hourlyFormatter.dateFormat = @"h a";
        
        _dailyFormatter = [[NSDateFormatter alloc] init];
        _dailyFormatter.dateFormat = @"EEEE";
        
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.client = [[WeatherHTTPClient alloc] init];
    self.client.delegate = self;
    
    self.forcastWeatherArray = [NSMutableArray array];
    [self.forcastWeatherArray addObject:@""];
    
    
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //UINavigationBar
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:button];
    
    UIImage *background = [UIImage imageNamed:@"bg.png"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.blurredImageView.alpha = 0.8;
    //self.backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.blurredImageView setImageToBlur:background blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:^(NSError *error) {
        //NSLog(@"error = %@", error);
        //NSLog(@"the blurred image has been setted!");
    }];
    [self.view addSubview:self.blurredImageView];
    
    // 4
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
    

    
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    
    //NSLog(@"city = %@",self.city);
    if (self.city) {
        //NSLog(@"%@", self.city);
        [self updateCurrent:self.city];
    }
    
    
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    
    CGFloat inset = 20;
    
    CGFloat temperatureHeight = 110;
    CGFloat hiloHeight = 40;
    CGFloat iconHeight = 30;
    
    CGRect hiloFrame = CGRectMake(inset,
                                  headerFrame.size.height - hiloHeight,
                                  headerFrame.size.width - (2 * inset),
                                  hiloHeight);
    CGRect temperatureFrame = CGRectMake(inset,
                                         headerFrame.size.height - (temperatureHeight + hiloHeight),
                                         headerFrame.size.width - (2*inset),
                                         temperatureHeight);
    CGRect iconFrame = CGRectMake(inset,
                                  temperatureFrame.origin.y - iconHeight,
                                  iconHeight,
                                  iconHeight);
    CGRect conditionsFrame = iconFrame;
    conditionsFrame.size.width = self.view.bounds.size.width - (((2*inset) + iconHeight) + 10);
    conditionsFrame.origin.x = iconFrame.origin.x + (iconHeight + 10);
    
    self.headerView = [[HeaderView alloc] initWithFrame:headerFrame];
    [self.headerView addTemperatureLabel:temperatureFrame];
    [self.headerView addHiloLabel:hiloFrame];
    CGRect citypos = CGRectMake(0, 20, self.view.bounds.size.width, 30);
    [self.headerView addCityLabel:citypos];
    [self.headerView addConditionsLabel:conditionsFrame];
    
    self.tableView.tableHeaderView = self.headerView;
    
    
    
    
    
}

-(void)updateCurrent:(City *)city{
    //[[WXManager sharedManager] getCurrentWeather:city.weatherCode];
    [self.client getCurrentWeather:city.weatherCode];
    
    [self.client getForecastWeather:city.weatherCode];
}


//代理方法实现
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(NSDictionary *)weather{
    //NSLog(@"weather source = %@", weather);
    
    //NSLog(@"weatherData = %@", weather);
    
    if ([weather[@"weatherinfo"] count] > 10) {
        //self.forcastWeatherDate = weather;

        NSDate *date = [NSDate date];
        int interval = 1;

        //self.forcastWeatherDate = nil;
        for (int i = 1; i <= 6; i++) {
            NSString *temp = [NSString stringWithFormat:@"temp%d",i];
            Weather *_weather = [[Weather alloc] init];
            _weather.temp = weather[@"weatherinfo"][temp];
            
            _weather.cityName = weather[@"weatherinfo"][@"city"];
            
            NSString *fl = [NSString stringWithFormat:@"fl%d", i];
            _weather.fl = weather[@"weatherinfo"][fl];
            
            NSString *w = [NSString stringWithFormat:@"weather%d",i];
            _weather.weather = weather[@"weatherinfo"][w];
            
            //NSLog(@"tmep = %@", _weather.temp);
            interval = 60*60*24*i;
            
            NSDate *today = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
            
            //NSDate *earlierDate = [[NSDate alloc] initWithTimeInterval:-60*60 sinceDate:[NSDate date]];
            
            
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
            
            // 设置日期格式
            
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];

        
            NSString *dateString = [dateFormatter stringFromDate:today];
            // 打印结果：dateString = 年月日 2013/10/16 时间 05:15:43
            _weather.date_y = dateString;
            
            //NSLog(@"dateString = %@",dateString);
            //NSLog(@"weather = %@", _weather);
            [self.forcastWeatherArray addObject:_weather];
        }
        
        NSLog(@"forcasetData = %@", self.forcastWeatherArray);
        [self.tableView reloadData];
        return;
    }
    //self.cityLabel = weather[@"weatherinfo"][@"city"];
    self.headerView.cityLabel.text = weather[@"weatherinfo"][@"city"];
    self.headerView.temperatureLabel.text = weather[@"weatherinfo"][@"weather"];
    
    self.headerView.conditionsLabel.text = [NSString stringWithFormat:@"时间:%@", weather[@"weatherinfo"][@"ptime"]];
    
    self.headerView.hiloLabel.text = [NSString stringWithFormat:@"%@ / %@", weather[@"weatherinfo"][@"temp1"], weather[@"weatherinfo"][@"temp2"]];
    
    [self.tableView reloadData];
}

-(void)weatherHTTPCLient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error{

    NSLog(@"net working is bad");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    //CGRect bounds = [UIScreen mainScreen].bounds;
    
    self.backgroundImageView.frame = bounds;
    self.blurredImageView.frame = bounds;
    self.tableView.frame = bounds;
}

// 1
#pragma mark - UITableViewDataSource

// 2
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO: Return count of forecast
    
    if (section == 0) {
        //return 6;
        //NSLog(@"num = %d",[self.weatherData count]);
    }else if([self.forcastWeatherArray count] > 0){
        return [self.forcastWeatherArray count];
    }
    return 0;
    /*
    if (section == 0) {
        return MIN([self.weatherData count], 6) +1;
    }
    return MIN([self.forcastWeatherArray count], 6) + 1;
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // 3
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    // TODO: Setup the cell
    if (indexPath.section == 0) {
        //NSDictionary *weather = self.weatherData[indexPath.section][@"weatherinfo"];
        //NSLog(@"weatherinfo = %@", weather);
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            [self configureHeaderCell:cell title:@"未来6天预报"];
        }else{
            Weather *weather = (Weather *)self.forcastWeatherArray[indexPath.row];
            //cell.textLabel.text = weather.temp;
            [self configureForcastCell:cell forcastWeather:weather];
        }
        
    }
    //NSLog(@"weatherinfo");
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Determine cell height based on screen
    
    NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    NSLog(@"%f", self.view.frame.size.height / cellCount );
    return self.view.frame.size.height / cellCount;
    //return 44;
}

-(void)configureForcastCell:(UITableViewCell *)cell forcastWeather:(Weather *)weather{
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    NSString *tt = [NSString stringWithFormat:@"%@   %@", weather.date_y, weather.weather];
    cell.textLabel.text = tt;
    cell.detailTextLabel.text = weather.temp;
    //cell.imageView.image = [UIImage imageNamed:[weather imageName]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)configureHeaderCell:(UITableViewCell *)cell title:(NSString *)title{
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
