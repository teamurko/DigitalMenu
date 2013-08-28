//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "RestaurantLocation.h"
#import "MapViewController.h"
#import "RestaurantViewController.h"
#import "SplashScreenViewController.h"
#import "DataManager.h"
#import "UtilHelper.h"
#import "Debug.h"

#import "PickRestaurantViewController.h"

@interface PickRestaurantViewController ()

@end

@implementation PickRestaurantViewController

@synthesize restaurantsView = _restaurantsView;


CLLocationManager *locationManager = nil;
CLLocation *userLocation = nil;

BOOL isLoaded = NO;
BOOL didStartLoading = NO;

- (id) init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void) loadData
{
    debug();
    isLoaded = NO;
    while (!userLocation) {
        [NSThread sleepForTimeInterval:0.1];
    }
    [DataManager load:userLocation];
    isLoaded = YES;
}

- (void) showSplashScreen:(BOOL)animated
{
    debug();
    SplashScreenViewController *splashViewController = [[SplashScreenViewController alloc] init];
    splashViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    splashViewController.delegate = self;
    [self presentViewController:splashViewController animated:animated completion:nil];
}

- (void) dismissSplashScreen:(BOOL)animated
{
    debug();
    [[self presentedViewController] dismissViewControllerAnimated:animated completion:nil];
}


- (void) viewDidLoad
{
    debug();
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeVisible) name:@"makeVisible" object:nil];
}

- (void) showRestaurantView: (NSInteger)restaurandId andAnimated:(BOOL)animated
{
    RestaurantViewController *restaurantViewController = [[RestaurantViewController alloc] initWithRestaurandId:restaurandId];
    restaurantViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:restaurantViewController animated:YES];
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

- (void) addMapView:(UIView*) view
{
    debug();
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    for (NSDictionary* restaurantData in [DataManager nearbyRestaurants]) {
        NSInteger restaurantId = [[restaurantData objectForKey:@"id"] integerValue];
        CLLocation *location = [DataManager restaurantLocation:restaurantId];
        NSString *name = [NSString stringWithFormat:@"%@", [restaurantData objectForKey:@"name"]];
        RestaurantLocation *position = [[RestaurantLocation alloc] initWithPosition:location.coordinate andName:name];
        [mapView addAnnotation:position];
        [mapView setShowsUserLocation:YES];
        [mapView setCenterCoordinate:location.coordinate animated:YES];
    }
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    region.center = mapView.region.center;
    span.latitudeDelta = mapView.region.span.latitudeDelta / 2000;
    span.longitudeDelta = mapView.region.span.longitudeDelta / 2000;
    region.span = span;
    [mapView setRegion:region animated:YES];
    
    [view addSubview:mapView];

}

- (void) loadView
{
    debug();
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
        [self addMapView:self.view];

        self.restaurantsView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 300)];
        self.restaurantsView.layer.borderWidth = 1.0f;
        [self.restaurantsView setDelegate:self];
        [self.restaurantsView setDataSource:self];
        
        [self.view addSubview:self.restaurantsView];
        
        self.view.clipsToBounds = YES;
        [self reloadInputViews];
    }
    [NSThread sleepForTimeInterval:0.1];
}

- (void) viewDidAppear:(BOOL)animated
{
    debug();
    [super viewDidAppear:animated];
}

- (void) viewWillAppear:(BOOL)animated
{
    debug();
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:NO];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    debug();
    if (locations.count > 0) {
        userLocation = [locations objectAtIndex:0];
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    debug();
    NSLog(@"%@", error);
}

- (BOOL) isDataLoaded
{
    return isLoaded;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    return [DataManager nearbyRestaurants].count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSDictionary *restaurant = [[DataManager nearbyRestaurants] objectAtIndex:indexPath.row];
    NSInteger restaurantId = [[restaurant objectForKey:@"id"] integerValue];
    
    UIImage *logo = [UIImage imageNamed:@"stub_logo.png"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
    [logoView setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
    logoView.frame = CGRectMake(10, 5, 60, 60);
    [cell addSubview:logoView];

    
    UITextView *nameView = [[UITextView alloc] initWithFrame:CGRectMake(70, 0, 150, 30)];
    nameView.text = [restaurant objectForKey:@"name"];
    [nameView setFont:[UIFont boldSystemFontOfSize:14]];
    [cell addSubview:nameView];

    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 230, 20)];
//    descriptionLabel.layer.borderWidth = 1.0f;
    descriptionLabel.text = [restaurant objectForKey:@"description"];
    [descriptionLabel setFont:[UIFont systemFontOfSize:11]];
    [cell addSubview:descriptionLabel];

    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 27, 50, 15)];
    [distanceLabel setFont:[UIFont systemFontOfSize:10]];
    distanceLabel.text = [UtilHelper renderedDistanceKm:[UtilHelper approximateDistance:userLocation andTo:[DataManager restaurantLocation:restaurantId]]];
//    distanceLabel.layer.borderWidth = 1.0f;
    [cell addSubview:distanceLabel];
    
    UITextView *timeView = [[UITextView alloc] initWithFrame:CGRectMake(230, 5, 90, 20)];
    UIImageView *clockView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock.png"]];
    [clockView setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 1, 60, 20)];
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.text = [UtilHelper renderedWorkHours:[[restaurant objectForKey:@"open_from"] integerValue]  andTill:[[restaurant objectForKey:@"open_till"] integerValue]];
    [timeView addSubview:clockView];
    [timeView addSubview:timeLabel];
    [cell addSubview:timeView];
    
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
    NSArray *candidates = [DataManager nearbyRestaurants];
    NSString *id = [[candidates objectAtIndex:[indexPath row]] objectForKey:@"id"];
    [self showRestaurantView:id.intValue andAnimated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    [headerView setBackgroundColor:[UtilHelper mainGreenColor]];
    return headerView;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"";
//    int numRestaurantsNearby = [DataManager nearbyRestaurants].count;
//    NSString *message;
//    if (numRestaurantsNearby == 1) {
//        message = @"%d ресторан около вас";
//    } else if (numRestaurantsNearby > 1 && numRestaurantsNearby < 5) {
//        message = @"%d ресторана около вас";
//    } else {
//        message = @"%d ресторанов около вас";
//    }
//    return [[NSString alloc] initWithFormat:message, numRestaurantsNearby];
//}

@end
