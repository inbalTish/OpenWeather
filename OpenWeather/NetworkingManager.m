//
//  NetworkingManager.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "NetworkingManager.h"
#import "SBJson.h"


@implementation NetworkingManager

static dispatch_once_t onceToken;
dispatch_queue_t delegateQueue;

-(id)init{
    self = [super init];
    if (self) {
        delegateQueue = dispatch_queue_create("com.inbaltish.mydelegatequeue", 0x0);
    }
    return self;
}

-(void)getWeatherForLocationWithUrlString:(NSString *)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self downloadDataFromURL:url withCompletionHandler:^(NSData *data){
        //Should keep the data thread-safe till location object is recieved in the VC and added to the locationsArray.
        dispatch_sync(delegateQueue, ^{
            if(data != nil){
                //Parse data
                NSString *recievedString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSDictionary *jsonDictionary = [parser objectWithString:recievedString];
                
                //Fill location object with values:
                Location *location = [[Location alloc]init];
                location.code = [jsonDictionary valueForKey:@"cod"];
                if([location.code isEqualToString:@"404"]){
                    self.locationObject = location;
                }else{
                    self.locationObject = [self makeLocationObjectWithJSONDictionary:jsonDictionary];
                }
                
            }else{
                //Alert network problem
            }
            
            //Notify ViewController and send it the Location object:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"finishedDownloadData" object:self.locationObject];
        });
    }];
}

//Since the downloaded occurs on different threads the data recieved should be thread-safe
-(void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void(^)(NSData *))completionHandler{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error != nil){
            //Alert problem only once:
            dispatch_once(&onceToken, ^{
                //Going back to main thread:
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([[NSThread currentThread]isMainThread]) {
                        NSLog(@"Download error: %@", error.localizedDescription);
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"problemWithDownloadFromServer" object:nil];
                        return;
                    }
                });
            });
            
        }else{
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            if(HTTPStatusCode != 200){
                //Alert status code
                NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
            }
            
            //Call the completion handler with the returned data on the main thread.
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                completionHandler(data);
            }];
        }
        
    }];
    
    [task resume];
}



-(Location *)makeLocationObjectWithJSONDictionary:(NSDictionary *)jsonDictionary{
    Clouds *clouds = [[Clouds alloc]init];
    NSDictionary *dic = [jsonDictionary valueForKey:@"clouds"];
    clouds.all = [dic valueForKey:@"all"];
    
    Rain *rain = [[Rain alloc]init];
    dic = [jsonDictionary valueForKey:@"rain"];
    rain.threeH = [dic valueForKey:@"3h"];
    
    Wind *wind = [[Wind alloc]init];
    dic = [jsonDictionary valueForKey:@"wind"];
    wind.speed = [dic valueForKey:@"speed"];
    wind.gust = [dic valueForKey:@"gust"];
    wind.deg = [dic valueForKey:@"deg"];
    
    Conditions *conditions = [[Conditions alloc]init];
    dic = [jsonDictionary valueForKey:@"main"];
    conditions.temp = [dic valueForKey:@"temp"];
    conditions.humidity = [dic valueForKey:@"humidity"];
    conditions.pressure = [dic valueForKey:@"pressure"];
    conditions.temp_max = [dic valueForKey:@"temp_max"];
    conditions.temp_min = [dic valueForKey:@"temp_min"];
    
    Weather *weather = [[Weather alloc]init];
    NSArray *arr = [jsonDictionary valueForKey:@"weather"];
    weather.weatherId = [arr[0] valueForKey:@"id"];
    weather.main = [arr[0] valueForKey:@"main"];
    weather.weatherDescription = [arr[0] valueForKey:@"description"];
    weather.icon = [arr[0] valueForKey:@"icon"];
    weather.weatherConditions = conditions;
    weather.wind = wind;
    weather.rain = rain;
    weather.clouds = clouds;
    
    Location *location = [[Location alloc]init];
    location.locationName = [jsonDictionary valueForKey:@"name"];
    location.code = [jsonDictionary valueForKey:@"cod"];
    location.locationId = [jsonDictionary valueForKey:@"id"];
    dic = [jsonDictionary valueForKey:@"coord"];
    location.latitude = [dic valueForKey:@"lat"];
    location.longitude = [dic valueForKey:@"lon"];
    dic = [jsonDictionary valueForKey:@"sys"];
    location.type = [dic valueForKey:@"type"];
    location.country = [dic valueForKey:@"country"];
    location.sunrise = [dic valueForKey:@"sunrise"];
    location.sunset = [dic valueForKey:@"sunset"];
    location.weather = weather;
    
    return location;
}




@end
