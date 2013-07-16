//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

#import "SplashScreenViewController.h"
#import "LoadingScreenViewController.h"
#import "CuisinesViewController.h"
#import "RestException.h"

#import "DataManager.h"
#import "Debug.h"

#import "MainViewController.h"

@interface MainViewController ()

- (MKUserLocation*) getCurrentLocation;

@end

@implementation MainViewController

CLLocationManager *locationManager;
MKUserLocation *userLocation;
BOOL isLoaded = NO;
BOOL didStartLoading = NO;
BOOL didGuess = NO;

@synthesize dataManager = _dataManager;
@synthesize restaurantsView = _restaurantsView;

- (MKUserLocation*) getCurrentLocation
{
//    NSLog(@"Get current loc");
//    if (nil == userLocation) {
//        @try {
//            userLocation = self.mapView.annotations[0];
//        }
//        @catch (NSException *exception) {
//            NSException *ex = [MenuException
//                           exceptionWithName:@"Cannot init user location"
//                           reason:@"No map annotations"
//                           userInfo:nil];
//            @throw ex;
//        }
//        @finally {
//        }
//        userLocation.title = [@"You are here:" stringByAppendingFormat:
//                            @"(%.4f, %.4f)",
//                            userLocation.coordinate.latitude,
//                            userLocation.coordinate.longitude];
//    }
//    return userLocation;
}

- (void) loadData
{
    debug();
    isLoaded = false;
    [NSThread sleepForTimeInterval:2];
    if (!self.dataManager) {
        self.dataManager = [[DataManager alloc] init];
    }
    [self.dataManager load];
    [self.dataManager restaurantsByLocation:37.5843 andLatitude:55.7475];
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
    [self loadView];
}

- (void) addGuessView
{
    UIView *guessView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, 280, 140)];
    guessView.layer.borderWidth = 1.0f;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 240, 40)];
    textLabel.text = @"    Вы находитесь в ресторане X?";
    [textLabel setFont:[UIFont boldSystemFontOfSize:12]];
    textLabel.layer.borderWidth = 1.0f;
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 70, 80, 40)];
    [yesButton setBackgroundColor:[UIColor blueColor]];
    [yesButton setTitle:@"YES" forState:UIControlStateNormal];
    [yesButton setTitle:@"NO" forState:UIControlStateSelected];
    yesButton.userInteractionEnabled = YES;
    yesButton.layer.borderWidth = 2.0f;
    
    [guessView addSubview:textLabel];
    [guessView addSubview:yesButton];
    
    [self.view addSubview:guessView];
}

- (void) loadView
{
    if (!didStartLoading && !isLoaded) {
        didStartLoading = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            [self loadData];
        });
        [self showSplashScreen:YES];
    } else if (isLoaded) {
        UIView *mainView = [[UIView alloc] init];
        [mainView setBackgroundColor:[UIColor whiteColor]];
        self.view = mainView;

        self.restaurantsView = [[UITableView alloc] initWithFrame:CGRectMake(10, 150, 300, 250)];
        self.restaurantsView.layer.borderWidth = 1.0f;
        [self.restaurantsView setHidden:YES];
        
        [self.view addSubview:self.restaurantsView];
        
        
        UILabel *restaurantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 300, 20)];
        restaurantsLabel.text = @"  Ближайшие рестораны";
        restaurantsLabel.layer.borderWidth = 1.0f;
        [restaurantsLabel setHidden:YES];
        [self.view addSubview:restaurantsLabel];
        
        [self addGuessView];
        self.view.clipsToBounds = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.mapView.showsUserLocation = YES;
//    if (nil == locationManager) {
//        locationManager = [[CLLocationManager alloc] init];
//    }
//    [locationManager setDelegate:self];
//    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
//    locationManager.distanceFilter = 500;
//    [locationManager startUpdatingLocation];
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


- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
- (IBAction)showRestaurants:(id)sender {
    self.userName = self.nameField.text;
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
    NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", nameString];
    self.gTitle.text = greeting;
}


- (BOOL) textFieldShouldReturn:(UITextField *) theTextField {
    if (theTextField == self.nameField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}
 */

- (IBAction)showLocation:(id)sender {
    /*
    CLLocation *location = locationManager.location;
    NSLog(@"Annotations %@", self.mapView.annotations);
    for (MKUserLocation *location in self.mapView.annotations) {
        NSLog(@"Title: %@", location.title);
        NSLog(@"Description %@", location.description);
        NSLog(@"Debug description %@", location.debugDescription);
    }
    location.accessibilityLabel = @"You are here";
    NSLog(@"location %@", location);
    NSLog(@"Coordinates: %+.6f %+.6f\n", location.coordinate.latitude, location.coordinate.longitude);
     */
}

@end
