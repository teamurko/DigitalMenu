//
//  CuisinesViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 25.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "CuisinesViewController.h"
#import "DishCategoriesViewController.h"

@interface CuisinesViewController ()

@end

@implementation CuisinesViewController

@synthesize dataManager = _dataManager;
@synthesize houseId = _houseId;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithHouseId:(NSString*) theHouseId
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.houseId = theHouseId;
    }
    return self;
}

- (void) loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.dataManager = [[DataManager alloc] init];
    [self.dataManager load];
    self.view = tableView;
    [tableView reloadData];
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

- (void)viewWillAppear:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"%@ cuisines", self.houseId];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@", [self.dataManager houseIds]);
    NSLog(@"House name: %@", self.houseId);
    NSLog(@"Row no %d", [[self.dataManager cuisines:self.houseId] count]);
    return [[self.dataManager cuisines:self.houseId] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSArray *cuisineNames = [self.dataManager cuisines:self.houseId];
    cell.textLabel.text = [cuisineNames objectAtIndex:[indexPath row]];
    
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
    NSLog(@"Select cuisine");
    NSString *cuisineId = [[[[self.dataManager houseInfo:self.houseId] objectForKey:@"cuisines"] allKeys] objectAtIndex:[indexPath row]];
    DishCategoriesViewController *viewController = [[DishCategoriesViewController alloc] initWithData:self.dataManager andHouseId:self.houseId andCuisineId:cuisineId];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
