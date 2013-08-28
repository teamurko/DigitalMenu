//
//  RestaurantViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 17.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "UtilHelper.h"
#import "DataManager.h"
#import "DishViewController.h"
#import "MapViewController.h"
#import "RestaurantViewController.h"
#import "PickRestaurantViewController.h"
#import "OrderViewController.h"

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
NSMutableArray *ids;

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
    chosenCuisineId = [[ids objectAtIndex:segmentControl.selectedSegmentIndex] integerValue];
    //FIXME do not fucking write shit code
    UITableView *tableView = [self.view.subviews objectAtIndex:[self.view subviews].count - 2];
    [tableView reloadData];
}

- (void) showOrder:(id)sender
{
    debug();
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:orderViewController animated:YES];
}

- (void) loadView
{
    debug();
    [super loadView];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:NO];
    
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    self.view.backgroundColor = [UIColor whiteColor];
    
	NSMutableArray *segmentTextContent = [[NSMutableArray alloc] init];
    ids = [[NSMutableArray alloc] init];
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 240)];
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

- (void) backToAll
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"makeVisible" object:nil];
}

- (void) showMenu
{
    debug();

//    MapViewController *mapViewController = [[MapViewController alloc] initWithRestaurandId:self.restaurantId];
//    mapViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void) showMap
{
    debug();
}

- (void) showOrder
{
    debug();
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"navigation_bar.png"];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];

    UIView *backButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"back2.png"] andActImage:[UIImage imageNamed:@"back_act.png"] andAction:@selector(backToAll) offsetTop:9 offsetBottom:0 offsetRight:0 offsetLeft:9];
    backButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    
    UIView *menuButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"menu.png"] andActImage:[UIImage imageNamed:@"menu_act.png"] andAction:@selector(showMenu) offsetTop:9 offsetBottom:0 offsetRight:9 offsetLeft:0];
    menuButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:menuButtonView];

    self.navigationItem.rightBarButtonItem = menuButton;
    self.navigationItem.leftBarButtonItem = backButton;
    NSDictionary *data = [DataManager restaurantById:self.restaurantId];
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 40, 40);
    self.navigationItem.titleView.layer.borderWidth = 1.0f;
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"name"]];

    UIImage *toolbarImage = [UIImage imageNamed:@"restaurant_description_footer.png"];
    [self.navigationController.toolbar setBackgroundImage:toolbarImage forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
  
    UIView *mapButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"mapButton.png"] andActImage:[UIImage imageNamed:@"mapButtonAct.png"] andAction:@selector(showMap) offsetTop:15 offsetBottom:12 offsetRight:35 offsetLeft:32];
    mapButtonView.layer.borderWidth = 1;
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithCustomView:mapButtonView];
    
    UIView *restButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"restButton.png"] andActImage:[UIImage imageNamed:@"restButtonAct.png"] andAction:@selector(showMenu) offsetTop:15 offsetBottom:12 offsetRight:35 offsetLeft:35];
    restButtonView.layer.borderWidth = 1;
    UIBarButtonItem *restButton = [[UIBarButtonItem alloc] initWithCustomView:restButtonView];

    UIView *orderButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"orderButton.png"] andActImage:[UIImage imageNamed:@"orderButtonAct.png"] andAction:@selector(showOrder) offsetTop:15 offsetBottom:12 offsetRight:35 offsetLeft:35];
    orderButtonView.layer.borderWidth = 1;
    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithCustomView:orderButtonView];

    [self setToolbarItems:[NSArray arrayWithObjects:mapButton, restButton, orderButton, nil]];
//    UIBarButtonItem *mapButton = [Util]
//    NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
//    [toolbarItems addObject:backButton];
//    [toolbarItems addObject:toolbarImage];
//    [self setToolbarItems:toolbarItems];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
