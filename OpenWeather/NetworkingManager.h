//
//  NetworkingManager.h
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Weather.h"
#import "Conditions.h"
#import "Wind.h"
#import "Rain.h"
#import "Clouds.h"

@interface NetworkingManager : NSObject


@property (strong) Location *locationObject;


-(void)getWeatherForLocationWithUrlString:(NSString *)urlString;


@end
