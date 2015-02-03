//
//  Location.h
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface Location : NSObject

@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *sunrise;
@property (nonatomic, strong) NSString *sunset;

@property (nonatomic, strong) Weather *weather;





@end
