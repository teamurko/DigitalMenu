//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

#import "RestaurantViewController.h"
#import "SplashScreenViewController.h"
#import "LoadingScreenViewController.h"
#import "CuisinesViewController.h"
#import "RestException.h"
#import "WCAlertView.h"
#import "DataManager.h"
#import "Debug.h"

#import "PickRestaurantViewController.h"

@interface PickRestaurantViewController ()

@end

@implementation PickRestaurantViewController

@synthesize dataManager = _dataManager;
@synthesize restaurantsView = _restaurantsView;


CLLocationManager *locationManager = nil;
CLLocation *userLocation = nil;

BOOL isLoaded = NO;
BOOL didStartLoading = NO;
BOOL didGuess = NO;


- (void) loadData
{
    debug();
    isLoaded = false;
    [NSThread sleepForTimeInterval:2];
    if (!self.dataManager) {
        self.dataManager = [[DataManager alloc] init];
    }
    [self.dataManager load];
    isLoaded = true;
}

- (void) showSplashScreen:(BOOL)animated
{
    SplashScreenViewController *splashViewController = [[SplashScreenViewController alloc] init];
    splashViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    splashViewController.delegate = self;
    [splashViewController.navigationItem setHidesBackButton:YES];
    [self presentViewController:splashViewController animated:animated completion:nil];
}

- (void) dismissSplashScreen:(BOOL)animated
{
    [[self presentedViewController] dismissViewControllerAnimated:animated completion:nil];
}

- (void) showLoadingScreen:(BOOL)animated
{
    LoadingScreenViewController *loadingViewController = [[LoadingScreenViewController alloc] init];
    loadingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loadingViewController.delegate = self;
    [loadingViewController.navigationItem setHidesBackButton:YES];
    [self presentViewController:loadingViewController animated:YES completion:nil];
}

- (void) showLoading:(BOOL)animated
{
    [self showLoadingScreen:animated];
}

- (void) dismissLoadingScreen:(BOOL)animated
{
    [[self presentedViewController] dismissViewControllerAnimated:animated completion:nil];
}

- (void) showGuessView
{    
    UIFont * titleFont = [UIFont fontWithName:@"Chalkduster" size:12.0f];
    UIFont * messageFont = [UIFont fontWithName:@"Chalkduster" size:12.0f];
    
    // Set default appearnce block for all WCAlertViews
    // Similar functionality to UIAppearnce Proxy
    
    [WCAlertView setDefaultCustomiaztonBlock:^(WCAlertView *alertView) {
        alertView.labelTextColor = [UIColor colorWithRed:0.11f green:0.08f blue:0.39f alpha:1.00f];
        alertView.labelShadowColor = [UIColor whiteColor];
        
        UIColor *topGradient = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        UIColor *middleGradient = [UIColor colorWithRed:0.93f green:0.94f blue:0.96f alpha:1.0f];
        UIColor *bottomGradient = [UIColor colorWithRed:0.89f green:0.89f blue:0.92f alpha:1.00f];
        alertView.gradientColors = @[topGradient,middleGradient,bottomGradient];
        
        alertView.outerFrameColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
        
        alertView.buttonTextColor = [UIColor colorWithRed:0.11f green:0.08f blue:0.39f alpha:1.00f];
        alertView.buttonShadowColor = [UIColor whiteColor];
        
        alertView.titleFont = titleFont;
        alertView.messageFont = messageFont;
    }];
    
    NSString * guessPlaceName = [[[self.dataManager restaurantsByLocation:userLocation] objectAtIndex:0] objectForKey:@"name"];
    NSString *message = [[NSString alloc] initWithFormat:@"Вы находитесь в %@?", guessPlaceName];
    [WCAlertView showAlertWithTitle:@"Угадайка" message:message customizationBlock:^(WCAlertView *alertView) {
        
        // You can also set different appearance for this alert using customization block
        
        alertView.style = WCAlertViewStyleWhiteHatched;
        // alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            for (UIView *view in self.view.subviews) {
                [view setHidden:NO];
            }
        } else {
            [self showRestaurantView:YES];
        }
    } cancelButtonTitle:@"Нет, показать список" otherButtonTitles:@"Да, перейти на страницу", nil];
}

- (void) showRestaurantView:(BOOL)animated
{
    RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] init];
    restaurantViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    restaurantViewController.delegate = self;
    [restaurantViewController.navigationItem setHidesBackButton:NO animated:YES];
    restaurantViewController.navigationItem.leftBarButtonItem.title = @"List";
    restaurantViewController.navigationItem.rightBarButtonItem.title = @"Map";
    [self presentViewController:restaurantViewController animated:YES completion:nil];
}


- (void) startFindingLocation
{
    debug();
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
}

- (void) loadView
{
    if (!didStartLoading && !isLoaded) {
        didStartLoading = YES;
        [self startFindingLocation];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            [self loadData];
        });
        [self showSplashScreen:YES];
    } else if (isLoaded) {
        UIView *mainView = [[UIView alloc] init];
        [mainView setBackgroundColor:[UIColor whiteColor]];
        self.view = mainView;

        self.restaurantsView = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 300, 360)];
        self.restaurantsView.layer.borderWidth = 1.0f;
        [self.restaurantsView setDelegate:self];
        [self.restaurantsView setDataSource:self];
        [self.restaurantsView setHidden:YES];
        
        UILabel *restaurantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 20)];
        restaurantsLabel.text = @"  Выберите ваш ресторан из";
        restaurantsLabel.layer.borderWidth = 1.0f;
        [restaurantsLabel setHidden:YES];
        
        [self.view addSubview:self.restaurantsView];
        [self.view addSubview:restaurantsLabel];
        
        [self showGuessView];
        self.view.clipsToBounds = YES;
    }
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    debug();
    if (locations.count > 0) {
        userLocation = [locations objectAtIndex:0];
        //FIXME remove after debug
        userLocation = [[CLLocation alloc] initWithLatitude:55.7475 longitude:37.5843];
    }
    NSLog(@"Location: %@", userLocation);
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    debug();
    NSLog(@"%@", error);
}

- (void) viewWillAppear:(BOOL)animated
{
}

- (void) viewDidAppear:(BOOL)animated
{
}

- (BOOL) isDataLoaded
{
    return isLoaded;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    [self.dataManager restaurantsByLocation:<#(double)#> andLatitude:<#(double)#>]
    return [self.dataManager restaurantsByLocation:userLocation].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[[self.dataManager restaurantsByLocation:userLocation] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.layer.borderWidth = 1.0f;
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // for simplicity we provide only 1 section
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    [self showRestaurantView:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    int numRestaurantsNearby = [self.dataManager restaurantsByLocation:userLocation].count;
    NSString *message;
    if (numRestaurantsNearby == 1) {
        message = @"%d ресторан около вас";
    } else if (numRestaurantsNearby > 1 && numRestaurantsNearby < 5) {
        message = @"%d ресторана около вас";
    } else {
        message = @"%d ресторанов около вас";
    }
    return [[NSString alloc] initWithFormat:message, numRestaurantsNearby];
}

@end
