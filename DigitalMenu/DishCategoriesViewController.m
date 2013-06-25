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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *categories = [[[[self.dataManager houseInfo:self.houseId] objectForKey:@"cuisines"] objectForKey:self.cuisineId] allKeys];
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //TODO remove copy-paste
    NSArray *categories = [[[[self.dataManager houseInfo:self.houseId] objectForKey:@"cuisines"] objectForKey:self.cuisineId] allKeys];
    cell.textLabel.text = [categories objectAtIndex:[indexPath row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dishesCategory = [[[[[self.dataManager houseInfo:self.houseId] objectForKey:@"cuisines"] objectForKey:self.cuisineId] allKeys] objectAtIndex:[indexPath row]];
    DishesViewController *viewController = [[DishesViewController alloc] initWithData:self.dataManager andHouseId:self.houseId andCuisineId:self.cuisineId andDishesCategory:dishesCategory];
     [self.navigationController pushViewController:viewController animated:YES];
}

@end
