//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DigitalMenuViewController.h"
#import "MenuException.h"
#import "DataManager.h"

#import <CoreLocation/CoreLocation.h>


@interface DigitalMenuViewController ()

- (MKUserLocation*) getCurrentLocation;

@end

@implementation DigitalMenuViewController

CLLocationManager *locationManager;
MKUserLocation *userLocation;

@synthesize userName = _userName;
@synthesize gTitle = _gTitle;
@synthesize restaurantsFrontList = _restaurantsFrontList;
@synthesize restaurantButtons = _restaurantButtons;
@synthesize mapView = _mapView;
@synthesize nameField = _nameField;

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
    NSLog(@"Load data digital menu view controller");
    [dataManager load];
    
    if (nil == self.restaurantButtons) {
        self.restaurantButtons = [dataManager houseIds];
//        self.restaurantButtons = [[NSArray alloc] initWithObjects:@"John Donn", @"Cantina", @"McDonalds", @"KFC", nil];
//        self.restaurantButtons = [[NSArray alloc] init];
//        [self.restaurantButtons arrayByAddingObject:[[UIButton alloc] init]];
    }
    [self.restaurantsFrontList reloadAllComponents];
}

- (void)viewDidLoad
{
    [self loadData];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.showsUserLocation = YES;
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    [locationManager setDelegate:self];
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
    [super viewDidLoad];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
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
