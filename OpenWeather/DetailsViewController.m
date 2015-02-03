//
//  DetailsViewController.m
//  OpenWeather
//
//  Created by Dudi S on 1/12/15.
//  Copyright (c) 2015 Marat Ibragimov. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    self.locationNameLabel.text = self.locationFromMain.locationName;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = [self setLabelsForCellAtIndexPath:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [dic valueForKey:@"labelText"];
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:52/255.0f green:158/255.0f blue:216.0f alpha:1.0f];
    cell.detailTextLabel.text = [dic valueForKey:@"detailText"];
    
    return cell;
}


#pragma mark - Class methods

-(NSMutableDictionary *)setLabelsForCellAtIndexPath:(int)indexPathRow{
    NSMutableDictionary *cellTexts = [[NSMutableDictionary alloc]init];
    NSString *labelText;
    NSString *detailText;
    switch (indexPathRow){
        case 0:
            labelText = [NSString stringWithFormat: NSLocalizedString(@"Weather:", nil)];
            detailText = self.locationFromMain.weather.main;
            break;
        case 1:
            labelText = NSLocalizedString(@"Description:", nil);
            detailText = self.locationFromMain.weather.weatherDescription;
            break;
        case 2:
            labelText = NSLocalizedString(@"Min Temp:", nil);
            detailText = self.locationFromMain.weather.weatherConditions.temp_min;
            break;
        case 3:
            labelText = NSLocalizedString(@"Max Temp:", nil);
            detailText = self.locationFromMain.weather.weatherConditions.temp_max;
            break;
        case 4:
            labelText = NSLocalizedString(@"Humidity:", nil);
            detailText = self.locationFromMain.weather.weatherConditions.humidity;
            break;
        case 5:
            labelText = NSLocalizedString(@"Pressure:", nil);
            detailText = self.locationFromMain.weather.weatherConditions.pressure;
            break;
        case 6:
            labelText = NSLocalizedString(@"Wind Speed:", nil);
            detailText = self.locationFromMain.weather.wind.speed;
            break;
        case 7:
            labelText = NSLocalizedString(@"Wind Dir:", nil);
            detailText = self.locationFromMain.weather.wind.deg;
            break;
        case 8:
            labelText = NSLocalizedString(@"Clouds:", nil);
            detailText = self.locationFromMain.weather.clouds.all;
            break;
        case 9:
            labelText = NSLocalizedString(@"Rain:", nil);
            detailText = self.locationFromMain.weather.rain.threeH;
            break;
        case 10:
            labelText = NSLocalizedString(@"Sunrise:", nil);
            detailText = self.locationFromMain.sunrise;
            break;
        case 11:
            labelText = NSLocalizedString(@"Sunset:", nil);
            detailText = self.locationFromMain.sunset;
            break;
        default:
            labelText = @"";
            break;
    }
    
    [cellTexts setObject:labelText forKey:@"labelText"];
    [cellTexts setObject:detailText forKey:@"detailText"];

    return cellTexts;
}


#pragma mark - Button action

- (IBAction)backToMainScreen:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
