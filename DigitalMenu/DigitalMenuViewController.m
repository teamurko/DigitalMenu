//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DigitalMenuViewController.h"

#import <CoreLocation/CoreLocation.h>


@interface DigitalMenuViewController ()

@end

@implementation DigitalMenuViewController

@synthesize userName = _userName;
@synthesize gTitle = _gTitle;
@synthesize locationManager = _locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.showsUserLocation = YES;
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    [self.locationManager setDelegate:self];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
    [self.locationManager startUpdatingLocation];
    
//    MKAnnotationView *annotation = [[MKAnnotationView alloc] init];
//    [annotation setAccessibilityHint:@"You are here"];
//    [self.mapView addAnnotation:annotation];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"New location: %@", newLocation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    CLLocation *location = self.locationManager.location;
    location.accessibilityLabel = @"You are here";
    NSLog(@"location %@", location);
    NSLog(@"Coordinates: %+.6f %+.6f\n", location.coordinate.latitude, location.coordinate.longitude);

}
@end
