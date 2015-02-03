//
//  Clouds.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "Clouds.h"

@implementation Clouds

@synthesize all = _all;

-(NSString *)all{
    return _all;
}
-(void)setAll:(NSString *)all{
    _all = [NSString stringWithFormat:@"%@ %%", all];
}


@end
