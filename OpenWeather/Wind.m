//
//  Wind.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "Wind.h"
#import "Math.h"

@implementation Wind

@synthesize speed = _speed;
@synthesize deg = _deg;

-(NSString *)speed{
    return _speed;
}
-(void)setSpeed:(NSString *)speed{
    _speed = [NSString stringWithFormat:@"%@ mps", speed];
}

-(NSString *)deg{
    return _deg;
}
-(void)setDeg:(NSString *)deg{
    float degree = [deg floatValue];
    _deg = [self windDirectionFromDegrees:degree];
}


- (NSString *)windDirectionFromDegrees:(float)degrees{
    static NSArray *directions;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Initialize array on first call.
        directions = @[@"N", @"NNE", @"NE", @"ENE", @"E", @"ESE", @"SE", @"SSE", @"S", @"SSW", @"SW", @"WSW", @"W", @"WNW", @"NW", @"NNW"];
    });
    
    int i = (degrees + 11.25)/22.5;
    return directions[i % 16];
}


@end
