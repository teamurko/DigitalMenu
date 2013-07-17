//
//  DishesViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 26.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DishesViewController.h"

@interface DishesViewController ()

@end

@implementation DishesViewController
@synthesize houseId = _houseId;
@synthesize cuisineId = _cuisineId;
@synthesize dishesCategory = _dishesCategory;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithData:(DataManager*)theDataManager andHouseId:(NSString*)theHouseId andCuisineId:(NSString*)theCuisineId andDishesCategory:(NSString*)theDishesCategory;
{
    self = [self init];
    if (self) {
        self.dataManager = theDataManager;
        self.houseId = theHouseId;
        self.cuisineId = theCuisineId;
        self.dishesCategory = theDishesCategory;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
