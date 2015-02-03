//
//  Conditions.h
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import <Foundation/Foundation.h>


//Weather conditions - object "main"
@interface Conditions : NSObject

@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *temp_min;
@property (nonatomic, strong) NSString *temp_max;



@end
