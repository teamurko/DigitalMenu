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

#import "CuisinesViewController.h"

@interface CuisinesViewController ()

@end

@implementation CuisinesViewController

@synthesize restaurantId = _restaurantId;

NSArray *cuisines;

- (id) initWithRestaurandId:(NSInteger)restaurantId
{
    self = [super init];
    if (self) {
        self.restaurantId = restaurantId;
        cuisines = nil;
    }
    return self;
}

- (void) loadCuisines
{
    if (!cuisines) {
        cuisines = [DataManager cuisinesByRestaurantId:self.restaurantId];        
    }
}

- (void) backToMainScreen
{
    debug();
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadView
{
    [self loadCuisines];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
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
    
//    self.navigationItem.title = [[cuisines objectAtIndex:currentCuisineIndex] objectForKey:@"name"];
    self.navigationItem.titleView.frame = CGRectMake(130, 15, 100, 20);
    self.navigationItem.title = @"Menu";
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    cuisines = nil;
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
    if (indexPath.row % 2 == 1) {
        return 5;
    }
    return [UtilHelper cellStandardHeight];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    [self loadCuisines];
    assert(cuisines.count > 0);
    return cuisines.count * 2 - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    [self loadCuisines];
    if (indexPath.row % 2 == 1) {
        return [UtilHelper gapCellView:tableView];
    }
    static float distanceBetweenImageAndName = 20;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIImageView *cuisineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cuisine_greek.png"]];
    cuisineImageView.frame = CGRectOffset(cuisineImageView.frame, 10, 23);
    NSString *cuisineName = [[cuisines objectAtIndex:indexPath.row / 2] objectForKey:@"name"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cuisineImageView.frame.origin.x + cuisineImageView.frame.size.width + distanceBetweenImageAndName, 20, 150, 45)];
    label.text = cuisineName;
    [label setFont:[UIFont systemFontOfSize:20]];
    label.backgroundColor = [UIColor clearColor];
//    label.layer.borderWidth = 1;
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    arrowImageView.frame = CGRectOffset(arrowImageView.frame, label.frame.origin.x
                                        + label.frame.size.width, [UtilHelper cellStandardHeight] / 2);
    
    [cell addSubview:label];
    [cell addSubview:cuisineImageView];
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
    [self loadCuisines];
    NSDictionary *cuisineData = [cuisines objectAtIndex:indexPath.row / 2];
    NSInteger cuisineId = [[cuisineData objectForKey:@"id"] integerValue];
    NSString *name = [cuisineData objectForKey:@"name"];
    CategoriesViewController *categoriesViewController = [[CategoriesViewController alloc] initWithCuisineId:cuisineId andName:name];
    [self.navigationController pushViewController:categoriesViewController animated:YES];
}


@end
