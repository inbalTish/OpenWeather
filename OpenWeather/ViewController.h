//
//  ViewController.h
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailsViewController.h"
#import "Location.h"
#import "NetworkingManager.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *userLocationActivityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *alertLabel;


- (IBAction)moveToDetailsScreen:(id)sender;





@end
