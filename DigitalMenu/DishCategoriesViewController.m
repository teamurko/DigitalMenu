//
//  DishCategoriesViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 25.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DishesViewController.h"
#import "DishCategoriesViewController.h"

@interface DishCategoriesViewController ()

@end

@implementation DishCategoriesViewController
@synthesize houseId = _houseId;
@synthesize cuisineId = _cuisineId;
@synthesize dataManager = _dataManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithData:(DataManager*)theDataManager andHouseId:(NSString *)theHouseId andCuisineId:(NSString *)theCuisineId
{
    self = [self init];
    if (self) {
        self.dataManager = theDataManager;
        self.houseId = theHouseId;
        self.cuisineId = theCuisineId;
        self.title = [NSString stringWithFormat:@"Dish categories, house %@, cuisine %@", self.houseId, self.cuisineId];
        self.tableView.scrollEnabled = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
