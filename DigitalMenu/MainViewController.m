//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SplashScreenViewController.h"
#import "LoadingScreenViewController.h"
#import "CuisinesViewController.h"
#import "MenuException.h"

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

@synthesize userName = _userName;
@synthesize gTitle = _gTitle;
@synthesize restaurantsFrontList = _restaurantsFrontList;
@synthesize restaurantButtons = _restaurantButtons;
@synthesize mapView = _mapView;
@synthesize nameField = _nameField;
@synthesize dataManager = _dataManager;
@synthesize restsViewController = _restsViewController;

- (MKUserLocation*) getCurrentLocation
{
    NSLog(@"Get current loc");
    if (nil == userLocation) {
        @try {
            userLocation = self.mapView.annotations[0];
        }
        @catch (NSException *exception) {
            NSException *ex = [MenuException
                           exceptionWithName:@"Cannot init user location"
                           reason:@"No map annotations"
                           userInfo:nil];
            @throw ex;
        }
        @finally {
        }
        userLocation.title = [@"You are here:" stringByAppendingFormat:
                            @"(%.4f, %.4f)",
                            userLocation.coordinate.latitude,
                            userLocation.coordinate.longitude];
    }
    return userLocation;
}

- (void) loadData
{
    isLoaded = false;
    debug();
    [NSThread sleepForTimeInterval:2];
    [dataManager load];
//    if (nil == self.restaurantButtons) {
//        self.restaurantButtons = [dataManager houseIds];
//    }
//    [self.restaurantsFrontList reloadAllComponents];
    isLoaded = true;
}

- (void) showSplashScreen:(BOOL)animated
{
    debug();
    SplashScreenViewController *splashViewController = [[SplashScreenViewController alloc] init];
    splashViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    splashViewController.delegate = self;
    [splashViewController.navigationItem setHidesBackButton:YES];
//    [self.navigationController pushViewController:splashViewController animated:YES];
    [self presentViewController:splashViewController animated:animated completion:nil];
}

- (void) dismissSplashScreen:(BOOL)animated
{
    debug();
    [[self presentedViewController] dismissViewControllerAnimated:animated completion:nil];
}

- (void) showLoadingScreen:(BOOL)animated
{
    debug();
    LoadingScreenViewController *loadingViewController = [[LoadingScreenViewController alloc] init];
    loadingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loadingViewController.delegate = self;
    [loadingViewController.navigationItem setHidesBackButton:YES];
    [self presentViewController:loadingViewController animated:YES completion:nil];
}

- (void) showLoading:(BOOL)animated
{
    debug();
    [self showLoadingScreen:animated];
}

- (void) dismissLoadingScreen:(BOOL)animated
{
    debug();
    [[self presentedViewController] dismissViewControllerAnimated:animated completion:nil];
    [self loadView];
}

- (void) loadView
{
    debug();
    if (isLoaded == NO) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            [self loadData];
        });
        [self showSplashScreen:YES];
    } else {
        UITextView *textView = [[UITextView alloc] init];
        textView.text = @"Main view";
        [textView setFont:[UIFont boldSystemFontOfSize:20]];
        [textView reloadInputViews];

        self.restsViewController.view = [[UITableView alloc] init];
        self.restsViewController.view.backgroundColor = [UIColor redColor];
        UIView *mainView = [[UIView alloc] init];
        self.view = mainView;
        [self.view addSubview:self.restsViewController.view];
    }
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    [locationManager setDelegate:self];
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
}

- (void) viewWillAppear:(BOOL)animated
{
//    [self showLoadingScreen:YES];
//    [NSThread sleepForTimeInterval:3];
//    [self dismissLoadingScreen:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    debug();
    /*
    while (true) {
        [NSThread sleepForTimeInterval:1];
        if (isDataLoaded) {
            [self dismissLoadingScreen:animated];
            NSLog(@"DATA LOADED");
            break;
        }
    } 
     */
}

- (BOOL) isDataLoaded
{
    NSLog(@"isDataLoaded %d", isLoaded);
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

- (IBAction)showNearestHouse:(id)sender {
    // implement nearest house find
    NSString *nearestHouseId = @"kfc";
    CuisinesViewController *viewController = [[CuisinesViewController alloc] initWithHouseId:nearestHouseId];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.restaurantButtons count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.restaurantButtons objectAtIndex:row];
}

-  (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated: (BOOL) animated {
    NSLog(@"Get row %d", row);
}

@end
