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
#import "RestaurantViewController.h"

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

- (void) loadView
{
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;

//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
//    navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"LIST" style:UIBarButtonSystemItemAction target:self action:@selector(printMessage)];
//    [navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 80, 280, 300)];
    tableView.layer.borderWidth = 3.0f;
    
    [self.view addSubview:tableView];
//    [self.view addSubview:navigationController.view];
    
    [self.view clipsToBounds];
}

- (void) returnToList
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) showOnMap
{
    debug();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithTitle:@"К списку" style:UIBarButtonItemStylePlain target:self action:@selector(returnToList)];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"На карте" style:UIBarButtonItemStyleDone target:self action:@selector(showOnMap)];

    self.navigationItem.rightBarButtonItem = mapButton;
    NSDictionary *data = [DataManager restaurantById:self.restaurantId];
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"name"]];
    self.navigationItem.leftBarButtonItem = listButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
