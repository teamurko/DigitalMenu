//
//  RestaurantViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 17.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "DataManager.h"
#import "DishViewController.h"
#import "MapViewController.h"
#import "RestaurantViewController.h"
#import "PickRestaurantViewController.h"

#define kSegmentedControlHeight 40.0
#define kLabelHeight			20.0

#define kLeftMargin				20.0
#define kTopMargin				10.0
#define kRightMargin			20.0
#define kTweenMargin			6.0

#define kTextFieldHeight		30.0


@interface RestaurantViewController ()

@end

@implementation RestaurantViewController
@synthesize restaurantId = _restaurantId;

NSInteger chosenCuisineId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id) initWithRestaurandId:(NSInteger)restaurantId
{
    debug();
    self = [super init];
    if (self) {
        self.restaurantId = restaurantId;
    }
    return self;
}

- (void)changeCuisine:(id)sender
{
    debug();
    NSLog(@"%@", sender);
    UISegmentedControl *segmentControl = (UISegmentedControl*)sender;
    NSLog(@"Segment index %d", segmentControl.selectedSegmentIndex);
}

- (void) showOrder:(id)sender
{
    debug();
    NSLog(@"%@", sender);
}

- (void) loadView
{
    debug();
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    self.view.backgroundColor = [UIColor whiteColor];
    
	NSMutableArray *segmentTextContent = [[NSMutableArray alloc] init];
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in [DataManager cuisinesByRestaurantId:self.restaurantId]) {
        [segmentTextContent addObject:[dict objectForKey:@"name"]];
        [ids addObject:[dict objectForKey:@"id"]];
    }
    
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    CGRect frame = CGRectMake(10, 10, 300, 40);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self action:@selector(changeCuisine:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
    chosenCuisineId = [[ids objectAtIndex:0] integerValue];
	
	[self.view addSubview:segmentedControl];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 250)];
    tableView.layer.borderWidth = 3.0f;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [orderButton addTarget:self action:@selector(showOrder:) forControlEvents:UIControlEventTouchDown];
    [orderButton setTitle:@"Заказ" forState:UIControlStateNormal];
    orderButton.frame = CGRectMake(120, 350, 80, 40);
    [self.view addSubview:orderButton];
    
    [self.view clipsToBounds];
}

- (void) returnToList
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"makeVisible" object:nil];
}

- (void) showOnMap
{
    debug();

    MapViewController *mapViewController = [[MapViewController alloc] initWithRestaurandId:self.restaurantId];
    mapViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithTitle:@"К списку" style:UIBarButtonItemStylePlain target:self action:@selector(returnToList)];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"На карте" style:UIBarButtonItemStyleDone target:self action:@selector(showOnMap)];

    self.navigationItem.rightBarButtonItem = mapButton;
    self.navigationItem.leftBarButtonItem = listButton;
    NSDictionary *data = [DataManager restaurantById:self.restaurantId];
    NSLog(@"%@", data);
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"name"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    return [DataManager dishCategoriesByCuisineId:chosenCuisineId].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[[DataManager dishCategoriesByCuisineId:chosenCuisineId] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.layer.borderWidth = 1.0f;
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // for simplicity we provide only 1 section
    debug();
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    NSDictionary *data = [[DataManager dishCategoriesByCuisineId:chosenCuisineId] objectAtIndex:indexPath.row];
    NSInteger categoryId = [[data objectForKey:@"id"] integerValue];
    NSString *name = [data objectForKey:@"name"];
    DishViewController *dishViewController = [[DishViewController alloc] initWithDishCategory:categoryId andName:name];
    [self.navigationController pushViewController:dishViewController animated:YES];
//    NSArray *candidates = [DataManager restaurantsByLocation:userLocation];
//    NSString *id = [[candidates objectAtIndex:[indexPath row]] objectForKey:@"id"];
//    [self showRestaurantView:id.intValue andAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Приятного аппетита!";
}


@end
