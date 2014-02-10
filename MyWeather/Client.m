//
//  Client.m
//  MyWeather
//
//  Created by rick on 14-2-8.
//  Copyright (c) 2014年 rick. All rights reserved.
//

#import "Client.h"
#import <AFNetworking/AFNetworking.h>
#import "Province.h"
#import "City.h"

static NSString *provinceUrl = @"http://flash.weather.com.cn/wmaps/xml/china.xml";
static NSString *ciryUrl = @"http://flash.weather.com.cn/wmaps/xml/%@.xml ";
static NSString *weatherUrl = @"http://m.weather.com.cn/data/%@.h";

@interface Client ()

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableString *outstring;

@end

@implementation Client

-(NSDictionary *)getAllCities{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allCities" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSDictionary *cities = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (cities != nil &&  error == nil) {
        //NSLog(@"data = %@", cities[@"China"][@"province"]);
        //NSLog(@"count = %d", [cities[@"China"][@"province"] count]);
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        for (int i = 0; i < [cities[@"China"][@"province"] count]; i++) {
            //statements
            NSDictionary *_temp = cities[@"China"][@"province"][i];
            Province *province = [[Province alloc] init];
            province.provinceName = _temp[@"name"];
            province.provinceId = _temp[@"id"];
            
            
            if ([_temp[@"city"] isKindOfClass:[NSDictionary class]]) {
                
                //NSLog(@"==NSDictionary==");
                //NSLog(@"city name = %@", _temp[@"city"][@"name"]);
                
                for (int j = 0; j < [_temp[@"city"][@"county"] count]; j++) {
                    NSDictionary *_city = _temp[@"city"][@"county"][j];
                    //NSLog(@"%@", _city);
                    City *city = [[City alloc] init];
                    city.cityName = _city[@"name"];
                    city.cityCode = _city[@"weatherCode"];
                    
                    [province.cities addObject:city];
                }
            }else if([_temp[@"city"] isKindOfClass:[NSArray class]]){
                //NSLog(@"id = %@", _temp[@"city"][@"id"]);
                //NSLog(@"===NSArray===");
                for (int j = 0; j < [_temp[@"city"] count]; j++) {
                    NSDictionary *_city = _temp[@"city"][j];
                    //NSLog(@"%@", _city);
                    City *city = [[City alloc] init];
                    city.cityName = _city[@"name"];
                    city.cityCode = _city[@"weatherCode"];
                    
                    [province.cities addObject:city];
                }
            }
            
            //NSLog(@"province.cities = %@", province.cities);
            
            [dic setObject:province forKey:[NSString stringWithFormat:@"%d", i]];
            
        }
        
        
        return dic;
    }
    
    
    
    
    return nil;
}
-(NSDictionary *)getProvinces{
    
    
    return nil;
}

-(NSDictionary *)getCities{

    return nil;
}

-(NSDictionary *)getWeather{

    
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    self.previousElementName = self.elementName;
    
    if (qName) {
        self.elementName = qName;
        NSLog(@"qName = %@", qName);
    }
    
    if([qName isEqualToString:@"current_condition"]){
        //self.currentDictionary = [NSMutableDictionary dictionary];
    }
    else if([qName isEqualToString:@"weather"]){
        //self.currentDictionary = [NSMutableDictionary dictionary];
    }
    else if([qName isEqualToString:@"request"]){
        //self.currentDictionary = [NSMutableDictionary dictionary];
    }
    
    self.outstring = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!self.elementName){
        return;
    }
    
    [self.outstring appendFormat:@"%@", string];
    NSLog(@"self.outstring = %@", self.outstring);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSLog(@"elementName = %@ , namespaceURI = %@", elementName, namespaceURI);
    
    /*
    // 1
    if([qName isEqualToString:@"current_condition"] ||
       [qName isEqualToString:@"request"]){
        [self.xmlWeather setObject:[NSArray arrayWithObject:self.currentDictionary] forKey:qName];
        self.currentDictionary = nil;
    }
    // 2
    else if([qName isEqualToString:@"weather"]){
        
        // Initalise the list of weather items if it dosnt exist
        NSMutableArray *array = [self.xmlWeather objectForKey:@"weather"];
        if(!array)
            array = [NSMutableArray array];
        
        [array addObject:self.currentDictionary];
        [self.xmlWeather setObject:array forKey:@"weather"];
        
        self.currentDictionary = nil;
    }
    // 3
    else if([qName isEqualToString:@"value"]){
        //Ignore value tags they only appear in the two conditions below
    }
    // 4
    else if([qName isEqualToString:@"weatherDesc"] ||
            [qName isEqualToString:@"weatherIconUrl"]){
        [self.currentDictionary setObject:[NSArray arrayWithObject:[NSDictionary dictionaryWithObject:self.outstring forKey:@"value"]] forKey:qName];
    }
    // 5
    else {
        [self.currentDictionary setObject:self.outstring forKey:qName];
    }
    
	self.elementName = nil;
     */
}
@end
