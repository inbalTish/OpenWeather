//
//  Rain.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "Rain.h"

@implementation Rain

@synthesize threeH = _threeH;

-(NSString *)threeH{
    return _threeH;
}
-(void)setThreeH:(NSString *)threeH{
    _threeH = [NSString stringWithFormat:@"%@ mm", threeH];
}


@end
