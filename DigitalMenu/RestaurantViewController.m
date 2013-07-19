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

- (void)segmentAction:(id)sender
{
    debug();
}

- (void) loadView
{
    debug();
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    self.view.backgroundColor = [UIColor whiteColor];
    
	NSMutableArray *segmentTextContent = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in [DataManager cuisinesByRestaurantId:self.restaurantId]) {
        [segmentTextContent addObject:[dict objectForKey:@"name"]];
    }
    
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    CGRect frame = CGRectMake(10, 10, 300, 40);
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
	
	[self.view addSubview:segmentedControl];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 250)];
    tableView.layer.borderWidth = 3.0f;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
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


@end
