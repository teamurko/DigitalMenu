//
//  DishViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "UtilHelper.h"
#import "DishViewController.h"
#import "DataManager.h"
#import "DishInfoViewController.h"
#import "OrderViewController.h"
#import "OrderData.h"

@interface DishViewController ()

@end

@implementation DishViewController
@synthesize name = _name;

NSArray *dishes;

- (id)initWithCategoryId:(NSInteger)categoryId andName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.cagegoryId = categoryId;
        self.name = name;
        dishes = nil;
    }
    return self;
}

- (void) loadDishes
{
    if (!dishes) {
        dishes = [DataManager dishesByCategoryId:self.cagegoryId];
    }
}

- (void) backToCategories
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) configureNavigationBar
{
    UIView *backButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"back2.png"] andActImage:[UIImage imageNamed:@"back_act.png"] andAction:@selector(backToCategories) offsetTop:9 offsetBottom:0 offsetRight:0 offsetLeft:9];
    backButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = self.name;
    self.navigationItem.titleView.frame = CGRectMake(130, 15, 100, 20);
}

- (void) loadView
{
    debug();
    [self loadDishes];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.view = tableView;
    [self configureNavigationBar];
}

- (void) showOrder:(id)sender
{
    debug();
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:orderViewController animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    dishes = nil;
}
- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1) {
        return 5;
    }
    return [UtilHelper cellStandardHeight] * 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    [self loadDishes];
    assert(dishes.count > 0);
    return dishes.count * 2 - 1;
}

- (void) showInfo:(id) sender
{
    debug();
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    NSDictionary *dishData = [dishes objectAtIndex:index];
    DishInfoViewController *dishInfoViewController = [[DishInfoViewController alloc] initWithDishId:[[dishData objectForKey:@"id"] integerValue] andName:[dishData objectForKey:@"name"]];
    [self.navigationController pushViewController:dishInfoViewController animated:YES];
}

- (void) addToOrder:(id)sender
{
    debug();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    if (indexPath.row % 2 == 1) {
        return [UtilHelper gapCellView:tableView];
    }
    [self loadDishes];
    const static float DIST_BETWEEN_NAME_AND_BUTTON = 10;
    const static float DIST_BETWEEN_NAME_AND_PRICE = 15;
    const static float DIST_BETWEEN_NAME_AND_WEIGHT = 10;
    const static float DIST_BETWEEN_WEIGHT_AND_DESCRIPTION = 10;
    NSDictionary *dishData = [dishes objectAtIndex:indexPath.row / 2];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    
    UIView *infoButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"info.png"] andActImage:[UIImage imageNamed:@"info.png"] andAction:@selector(showInfo:) offsetTop:10 offsetBottom:0 offsetRight:0 offsetLeft:10];
    ((UIButton*)[infoButtonView.subviews objectAtIndex:0]).tag = indexPath.row / 2;
    [cell addSubview:infoButtonView];
    
    NSString *dishName = [dishData objectForKey:@"name"];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 25)];
//    nameLabel.layer.borderWidth = 1;
    nameLabel.frame = CGRectOffset(nameLabel.frame, infoButtonView.frame.origin.x + infoButtonView.frame.size.width + DIST_BETWEEN_NAME_AND_BUTTON, 5);
    nameLabel.text = dishName;
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    nameLabel.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:nameLabel];

    
    NSString *priceString = [NSString stringWithFormat:@"%d руб", [[dishData objectForKey:@"price"] intValue] * 10];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    priceLabel.textAlignment = NSTextAlignmentRight;
//    priceLabel.layer.borderWidth = 1;
    priceLabel.text = priceString;
    [priceLabel setFont:[UIFont systemFontOfSize:15]];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.frame = CGRectOffset(priceLabel.frame, nameLabel.frame.origin.x
                                    + nameLabel.frame.size.width + DIST_BETWEEN_NAME_AND_PRICE, 5);
    
    [cell addSubview:priceLabel];

    //TODO use real weight
    NSString *weightString = [NSString stringWithFormat:@"%d г", 100];
    UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
//    weightLabel.layer.borderWidth = 1;
    weightLabel.text = weightString;
    [weightLabel setFont:[UIFont systemFontOfSize:12]];
    weightLabel.backgroundColor = [UIColor clearColor];
    
    weightLabel.frame = CGRectOffset(weightLabel.frame, nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + DIST_BETWEEN_NAME_AND_WEIGHT);
    
    [cell addSubview:weightLabel];
    
    UITextView *descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 180, 90)];
//    descriptionView.layer.borderWidth = 1;
    [descriptionView setUserInteractionEnabled:NO];
    descriptionView.frame = CGRectOffset(descriptionView.frame, 10, weightLabel.frame.origin.y
                                         + weightLabel.frame.size.height + DIST_BETWEEN_WEIGHT_AND_DESCRIPTION);
    descriptionView.text = [dishData objectForKey:@"summary"];
    
    [cell addSubview:descriptionView];

    UIImage *imageNormal = [UtilHelper imageFromColor:[UtilHelper orangeNormal] andSize:CGSizeMake(100, 30)];
    UIImage *imageSelected = [UtilHelper imageFromColor:[UtilHelper orangeSelected] andSize:CGSizeMake(100, 30)];
    UIView *addButtonView = [UtilHelper buttonView:self andImage:imageNormal andActImage:imageSelected andAction:@selector(addToOrder:) offsetTop:0 offsetBottom:0 offsetRight:0 offsetLeft:0];
    UILabel *actionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 80, 15)];
    actionTitle.text = @"Add to order";
//    actionTitle.layer.borderWidth = 1;
    [actionTitle setFont:[UIFont systemFontOfSize:14]];
    actionTitle.backgroundColor = [UIColor clearColor];
    actionTitle.textColor = [UIColor whiteColor];
    [addButtonView addSubview:actionTitle];
    
    addButtonView.frame = CGRectOffset(addButtonView.frame, descriptionView.frame.origin.x
                                       + descriptionView.frame.size.width + 10, descriptionView.frame.origin.y + 20);
    
    [cell addSubview:addButtonView];
    
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
}

@end
