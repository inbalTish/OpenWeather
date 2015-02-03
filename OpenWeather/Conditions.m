//
//  Conditions.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "Conditions.h"

@implementation Conditions

@synthesize temp = _temp;
@synthesize humidity = _humidity;
@synthesize pressure = _pressure;
@synthesize temp_max = _temp_max;
@synthesize temp_min = _temp_min;


-(NSString *)temp{
    return _temp;
}
-(void)setTemp:(NSString *)temp{
    double celcius = [temp doubleValue]-273.15;
    _temp = [NSString stringWithFormat:@"%.1f°", celcius];
}

-(NSString *)humidity{
    return _humidity;
}
-(void)setHumidity:(NSString *)humidity{
    _humidity = [NSString stringWithFormat:@"%@ %%", humidity];
}

-(NSString *)pressure{
    return _pressure;
}
-(void)setPressure:(NSString *)pressure{
    _pressure = [NSString stringWithFormat:@"%@ hPa", pressure];
}

-(NSString *)temp_max{
    return _temp_max;
}
-(void)setTemp_max:(NSString *)temp_max{
    double celcius = [temp_max doubleValue]-273.15;
    _temp_max = [NSString stringWithFormat:@"%.1f°", celcius];
}

-(NSString *)temp_min{
    return _temp_min;
}
-(void)setTemp_min:(NSString *)temp_min{
    double celcius = [temp_min doubleValue]-273.15;
    _temp_min = [NSString stringWithFormat:@"%.1f°", celcius];
}





@end
