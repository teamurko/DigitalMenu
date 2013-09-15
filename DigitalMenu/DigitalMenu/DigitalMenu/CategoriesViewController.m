//
//  CategoriesViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 01.09.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "UtilHelper.h"
#import "DataManager.h"
#import "DishViewController.h"
#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController
@synthesize cuisineId = _cuisineId;
@synthesize name = _name;

NSArray *categories;

- (id) initWithCuisineId:(NSInteger)cuisineId andName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.cuisineId = cuisineId;
        self.name = name;
        categories = nil;
    }
    return self;
}

- (void) loadCategories
{
    if (!categories) {
        categories = [DataManager dishCategoriesByCuisineId:self.cuisineId];
    }
}

- (void) loadView
{
    debug();
    [self loadCategories];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (void) backToCuisines
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) configureNavigationBar
{
    UIView *backButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"back2.png"] andActImage:[UIImage imageNamed:@"back_act.png"] andAction:@selector(backToCuisines) offsetTop:9 offsetBottom:0 offsetRight:0 offsetLeft:9];
    backButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = self.name;
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
    if (indexPath.row % 2 == 1) {
        return 5;
    }
    return [UtilHelper cellStandardHeight];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    [self loadCategories];
    assert(categories.count > 0);
    return categories.count * 2 - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    [self loadCategories];
    if (indexPath.row % 2 == 1) {
        return [UtilHelper gapCellView:tableView];
    }

    static float distanceBetweenImageAndName = 20;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIImageView *cuisineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"soup_picture.png"]];
    cuisineImageView.frame = CGRectOffset(cuisineImageView.frame, 10, 8);
    NSString *categoryName = [[categories objectAtIndex:indexPath.row / 2] objectForKey:@"name"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cuisineImageView.frame.origin.x + cuisineImageView.frame.size.width + distanceBetweenImageAndName, 20, 150, 45)];
    label.text = categoryName;
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
    [self loadCategories];
    NSDictionary *categoryData = [categories objectAtIndex:indexPath.row / 2];
    NSInteger categoryId = [[categoryData objectForKey:@"id"] integerValue];
    NSString *categoryName = [categoryData objectForKey:@"name"];
    DishViewController *dishViewController = [[DishViewController alloc] initWithCategoryId:categoryId andName:categoryName];
    [self.navigationController pushViewController:dishViewController animated:YES];
}


@end
