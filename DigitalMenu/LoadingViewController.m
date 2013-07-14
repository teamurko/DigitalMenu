//
//  LoadingViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "LoadingViewController.h"
#import "MainViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadView
{
    NSLog(@"LOAD LOADING SCREEN VIEW");
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"Loading nearest restaurants..";
    [textView setTextColor:[UIColor blackColor]];
    [textView setTextAlignment:NSTextAlignmentJustified];
    self.view = textView;
    [textView reloadInputViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
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
