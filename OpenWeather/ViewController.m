//
//  ViewController.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    //Class extention:
    CLLocationManager *locationManager;
    CLLocation *userLocation;
    NetworkingManager *netManager;
    Location *locationWeather;
    NSMutableArray *urlsArray;
    NSMutableDictionary *locationsDict;

}

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //3 Fixed locations: London,gb=2643743, New York,us=5128581, Sydney,au=2147714
    urlsArray = [[NSMutableArray alloc]initWithObjects:@"http://api.openweathermap.org/data/2.5/weather?id=2643743", @"http://api.openweathermap.org/data/2.5/weather?id=5128581", @"http://api.openweathermap.org/data/2.5/weather?id=2147714", nil];
    locationsDict = [[NSMutableDictionary alloc]initWithCapacity:4];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getWeatherForAllLocations) name:@"gotUserLocation" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationObjectFromNotification:) name:@"finishedDownloadData" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showServerAlert) name:@"problemWithDownloadFromServer" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [self initLocationService];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    //Remove all observers from viewController:
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    self.userLocationActivityIndicator = nil;
}

#pragma mark - class methods

-(void)getWeatherForAllLocations{
        if (userLocation != nil) {
        //Formatting the url's String for the request:
        float latitude = userLocation.coordinate.latitude;
        float longitude = userLocation.coordinate.longitude;
        //(OpenWeatherMap API service needs up to 2 places after decimal mark)
        NSString *urlString = [NSString stringWithFormat: @"http://api.openweathermap.org/data/2.5/weather?lat=%.2f&lon=%.2f", latitude, longitude];
        
        [urlsArray insertObject:urlString atIndex:0];
        
        netManager = [[NetworkingManager alloc]init];
        for(int i = 0; i < urlsArray.count; i++){
            NSString *stringURL = urlsArray[i];
            [netManager getWeatherForLocationWithUrlString:stringURL];
        }
    }
}

-(void)getLocationObjectFromNotification:(NSNotification *)notification{
    if([notification.object isKindOfClass:[Location class]]){
        //TODO: thread-safe queue
        locationWeather = [notification object];
        
        if([locationWeather.code isEqualToString:@"404"]){
            self.alertLabel.text = @"Opss, no data for this location";
            [self.userLocationActivityIndicator stopAnimating];
        }else{
            int index = 0;
            if([locationWeather.locationId isEqualToString:@"2643743"]){
                //London
                index = 1;
            }else if([locationWeather.locationId isEqualToString:@"5128581"]){
                //New York
                index = 2;
            }else if([locationWeather.locationId isEqualToString:@"2147714"]){
                //Sydney
                index = 3;
            }else{
                //User location
                index = 0;
            }
            
            NSString *key = [NSString stringWithFormat:@"%d", index];
            [locationsDict setObject:locationWeather forKey:key];
            
            [self displayWeatherForLocationByViewTag:index];
        }
    }
}

-(void)displayWeatherForLocationByViewTag:(int)tag{
    if(tag == 0){
        //First view have tag 4 instead of 0
        tag = 4;
    }
    UIView *currentView = [self.view viewWithTag:tag];
    NSArray *subViewsArray = currentView.subviews;
    if(subViewsArray.count != 0){
        for(UIView *subview in subViewsArray){
            if([subview isMemberOfClass:[UIButton class]]){
                UIButton *nameBtn = (UIButton *)subview;
                [nameBtn setTitle: locationWeather.locationName forState: UIControlStateNormal];
            }else if([subview isMemberOfClass:[UIActivityIndicatorView class]]){
                UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)subview;
                [activityIndicator stopAnimating];
            }else if([subview isMemberOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)subview;
                NSString *initText = label.text;
                if([initText isEqualToString:@"00"]){
                   label.text = locationWeather.weather.weatherConditions.temp;
                }else{
                  label.text = @"";
                }
            }
        }
    }
}


#pragma mark - CLLocationManagerDelegate (standard location service)

-(void)initLocationService{
    [self.userLocationActivityIndicator startAnimating];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //Checking and getting user autorization:
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ){
        //Will open a prompt to get user's approval (&will continue at didChangeAuthorizationStatus):
        [locationManager requestWhenInUseAuthorization];
        //[locationManager requestAlwaysAuthorization];
    }else{
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //Passing user location to global variable:
    userLocation = [locations lastObject];
    //Need only current location when user open app:
    [locationManager stopUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"gotUserLocation" object:nil];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"Location error: %@", error.localizedDescription);
    //showLocationFailerAlert
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch(status){
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"Location services- Status not determined");
            //showUserPermissionsAlert (and show default values on screen)
        }
            break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"Location services- Denied");
            //showUserPermissionsAlert (and show default values on screen)
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            NSLog(@"Location services- Authorized");
            [locationManager startUpdatingLocation]; //Will update location immediately
        }
            break;
        default:
            break;
    }
}

#pragma mark - Button action

- (IBAction)moveToDetailsScreen:(id)sender {
    //Get the location object for locationsDict by the sender's tag:
    UIButton *btn = (UIButton*)sender;
    int index = btn.tag;

    //Opening details VC and passing it the location object:
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *detailsVC = (DetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"detailsVC"];
    
    NSString *key = [NSString stringWithFormat:@"%d", index];
    detailsVC.locationFromMain = [locationsDict valueForKey:key];

    [self presentViewController:detailsVC animated:NO completion:nil];
}

#pragma mark - UIAlertView

-(void)showServerAlert{
    NSLog(@"Sorry, problem with download from server");
}

-(void)showUserPermissionsAlert{
    NSLog(@"Please go to your Settings app to allow location-services");
}

-(void)showLocationFailerAlert{
    NSLog(@"Opsy, Failed to Get Your Location");
}


@end
