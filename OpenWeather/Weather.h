//
//  Weather.h
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Conditions.h"
#import "Wind.h"
#import "Rain.h"
#import "Clouds.h"


@interface Weather : NSObject

@property (nonatomic, strong) NSString *weatherId;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) Conditions *weatherConditions;
@property (nonatomic, strong) Wind *wind;
@property (nonatomic, strong) Rain *rain;
@property (nonatomic, strong) Clouds *clouds;



@end
