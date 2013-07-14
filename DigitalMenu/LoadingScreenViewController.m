//
//  LoadingViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "LoadingScreenViewController.h"
#import "MainViewController.h"
#import "Debug.h"

@interface LoadingScreenViewController ()

@end

@implementation LoadingScreenViewController

CLLocationManager *locationManager;
CLLocation *location;
bool locationFound = NO;

- (CLLocation*) getCurrentLocation
{
    NSLog(@"GET CURRENT LOCATION");
    return location;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) loadView
{
    debug();
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"Loading nearest restaurants..";
    [textView setFont:[UIFont boldSystemFontOfSize:17]];
    [textView setTextColor:[UIColor blackColor]];
    [textView setTextAlignment:NSTextAlignmentJustified];
    [textView setFrame:CGRectMake(10, 80, 100, 120)]; //FIXME does not work
    [textView reloadInputViews];
    self.view = textView;
}

- (void) viewDidAppear:(BOOL)animated
{
    debug();
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    while ([self.delegate isDataLoaded] == NO) {
        [NSThread sleepForTimeInterval:0.1];
    }
    [self.delegate dismissLoadingScreen:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
}

- (void) viewWillDisappear:(BOOL)animated
{
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"DID FAIL WITH ERROR: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    locationFound = NO;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"DID UPDATE LOCATION: %@", newLocation);
    location = newLocation;
    if (locationFound == NO) {
        locationFound = YES;
        MainViewController *mainController = [[MainViewController alloc] init];
        [mainController.navigationItem setHidesBackButton:YES];
        [self.navigationController pushViewController:mainController animated:YES];
    }
}

@end
