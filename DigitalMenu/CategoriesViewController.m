//
//  CategoriesViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 27.08.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "UtilHelper.h"
#import "DataManager.h"

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController

@synthesize restaurantId = _restaurantId;

NSInteger currentCuisineIndex;

NSArray *cuisines;
NSArray *dishCategories;

const float CELL_HEIGHT = 83;
- (id) initWithRestaurandId:(NSInteger)restaurantId
{
    self = [super init];
    if (self) {
        self.restaurantId = restaurantId;
    }
    return self;
}

- (void) backToMainScreen
{
    debug();
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadView
{
    cuisines = [DataManager cuisinesByRestaurantId:self.restaurantId];
    assert(cuisines.count > 0);
    currentCuisineIndex = 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (void) configureNavigationBar
{
    UIView *backButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"back2.png"] andActImage:[UIImage imageNamed:@"back_act.png"] andAction:@selector(backToMainScreen) offsetTop:9 offsetBottom:0 offsetRight:0 offsetLeft:9];
    backButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = [[cuisines objectAtIndex:currentCuisineIndex] objectForKey:@"name"];
    self.navigationItem.titleView.frame = CGRectMake(130, 15, 100, 20);
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// table view methods

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    return CELL_HEIGHT;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    NSInteger cuisineId = [[[cuisines objectAtIndex:currentCuisineIndex] objectForKey:@"id"] integerValue];
    return [DataManager dishCategoriesByCuisineId:cuisineId].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    static float distanceBetweenImageAndName = 20;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIImageView *dishImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"soup_picture.png"]];
    dishImageView.frame = CGRectOffset(dishImageView.frame, 10, 8);
    NSInteger cuisineId = [[[cuisines objectAtIndex:currentCuisineIndex] objectForKey:@"id"] integerValue];
    if (!dishCategories) {
        dishCategories = [DataManager dishCategoriesByCuisineId:cuisineId];
    }
    NSString *categoryName = [[dishCategories objectAtIndex:indexPath.row] objectForKey:@"name"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(dishImageView.frame.origin.x + dishImageView.frame.size.width + distanceBetweenImageAndName, 20, 150, 45)];
    label.text = categoryName;
    [label setFont:[UIFont systemFontOfSize:20]];
    label.backgroundColor = [UIColor clearColor];
//    label.layer.borderWidth = 1;
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    arrowImageView.frame = CGRectOffset(arrowImageView.frame, label.frame.origin.x
                                        + label.frame.size.width, CELL_HEIGHT / 2);
    
    [cell addSubview:label];
    [cell addSubview:dishImageView];
    [cell addSubview:arrowImageView];
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    debug();
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
//    NSDictionary *data = [[DataManager dishCategoriesByCuisineId:chosenCuisineId] objectAtIndex:indexPath.row];
//    NSInteger categoryId = [[data objectForKey:@"id"] integerValue];
//    NSString *name = [data objectForKey:@"name"];
//    DishViewController *dishViewController = [[DishViewController alloc] initWithDishCategory:categoryId andName:name];
//    [self.navigationController pushViewController:dishViewController animated:YES];
    //    NSArray *candidates = [DataManager restaurantsByLocation:userLocation];
    //    NSString *id = [[candidates objectAtIndex:[indexPath row]] objectForKey:@"id"];
    //    [self showRestaurantView:id.intValue andAnimated:YES];
}


@end
