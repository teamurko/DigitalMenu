//
//  MapViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 19.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "RestaurantLocation.h"
#import "MapViewController.h"
#import "DataManager.h"
#import "Debug.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize restaurantId = _restaurantId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    debug();
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    self.view.backgroundColor = [UIColor whiteColor];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, 20, 300, 350)];
    CLLocation *location = [DataManager restaurantLocation:self.restaurantId];
    NSDictionary *restaurant = [DataManager restaurantById:self.restaurantId];

    RestaurantLocation *position = [[RestaurantLocation alloc] initWithPosition:location.coordinate andName:[restaurant objectForKey:@"name"]];
    [mapView addAnnotation:position];
    [mapView setShowsUserLocation:YES];
    [mapView setCenterCoordinate:location.coordinate animated:YES];
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    region.center = mapView.region.center;
    span.latitudeDelta = mapView.region.span.latitudeDelta / 20000;
    span.longitudeDelta = mapView.region.span.longitudeDelta / 20000;
    region.span = span;
    [mapView setRegion:region animated:YES];
    
    [self.view addSubview:mapView];
    
    [self.view clipsToBounds];
}

- (id)initWithRestaurandId:(NSInteger)restaurantId
{
    debug();
    self = [super init];
    if (self) {
        self.restaurantId = restaurantId;
    }
    return self;
}

- (void) returnToMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self action:@selector(returnToMenu)];
    
    NSDictionary *data = [DataManager restaurantById:self.restaurantId];
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"Ресторан %@", [data objectForKey:@"name"]];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
