//
//  Weather.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize weatherId = _weatherId;



-(NSString *)weatherId{
    return _weatherId;
}
-(void)setWeatherId:(NSString *)weatherId{
    _weatherId = [NSString stringWithFormat:@"%@", weatherId];
}


@end
