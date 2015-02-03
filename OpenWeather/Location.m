//
//  Location.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "Location.h"

@implementation Location


@synthesize code = _code;
@synthesize type = _type;
@synthesize locationId = _locationId;
@synthesize sunrise = _sunrise;
@synthesize sunset = _sunset;


-(NSString *)code{
    return _code;
}
-(void)setCode:(NSString *)code{
    _code = [NSString stringWithFormat:@"%@", code];
}


-(NSString *)type{
    return _type;
}
-(void)setType:(NSString *)type{
    _type = [NSString stringWithFormat:@"%@", type];
}


-(NSString *)locationId{
    return _locationId;
}
-(void)setLocationId:(NSString *)locationId{
    _locationId = [NSString stringWithFormat:@"%@", locationId];
}


- (NSString *)sunrise {
    return _sunrise;
}
- (void)setSunrise:(NSString *)sunrise {
    _sunrise = [self getTimeWithString:sunrise];
}


- (NSString *)sunset {
    return _sunset;
}
- (void)setSunset:(NSString *)sunset {
    _sunset = [self getTimeWithString:sunset];
}




-(NSString *)getTimeWithString:(NSString *)stringNumber{
    double dateNumber = [stringNumber doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNumber];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //Get only the hour:
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *stringDate = [formatter stringFromDate:date];
    return stringDate;
}


@end
