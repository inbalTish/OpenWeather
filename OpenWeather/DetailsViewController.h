//
//  DetailsViewController.h
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface DetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *detailsTable;

@property (strong, nonatomic) IBOutlet UILabel *locationNameLabel;

@property (nonatomic, strong) Location *locationFromMain;


- (IBAction)backToMainScreen:(id)sender;

@end
