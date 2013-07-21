//
//  OrderViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 21.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "OrderData.h"
#import "DataManager.h"
#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)cleanOrder:(id)sender
{
    debug();
    [OrderData clear];
    totalPrice_.text = @"0 руб";
    [totalPrice_ reloadInputViews];
    [dishesTable_ reloadData];
}

- (void) loadView
{
    debug();
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    self.view = mainView;
    
    int totalSum = 0;
    for (NSNumber* dishId in [OrderData dishIds]) {
        NSDictionary *dishData = [DataManager dishById:dishId.integerValue];
        totalSum += [[dishData objectForKey:@"price"] intValue];
    }
    
    UILabel *totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 330, 80, 40)];
    totalPriceLabel.text = @"Сумма";
    [self.view addSubview:totalPriceLabel];
    
    totalPrice_ = [[UILabel alloc] initWithFrame:CGRectMake(100, 330, 120, 40)];
    totalPrice_.text = [[NSString alloc] initWithFormat:@"%d руб", totalSum];
    [self.view addSubview:totalPrice_];
    
    dishesTable_ = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 300) style:UITableViewStylePlain];
    dishesTable_.layer.borderWidth = 1.0f;
    dishesTable_.delegate = self;
    dishesTable_.dataSource = self;
    [self.view addSubview:dishesTable_];
    
    [self.view clipsToBounds];
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
    UIBarButtonItem *cleanButton = [[UIBarButtonItem alloc] initWithTitle:@"Очистить" style:UIBarButtonItemStyleDone target:self action:@selector(cleanOrder:)];
    
    self.navigationItem.rightBarButtonItem = cleanButton;
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"Заказ"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    return [OrderData dishIds].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSInteger dishId = [[[OrderData dishIds] objectAtIndex:indexPath.row] integerValue];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    name.text = [[DataManager dishById:dishId] objectForKey:@"name"];
    name.layer.borderWidth = 1.0f;
    [cell addSubview:name];
    
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 45)];
    count.text = [[NSString alloc] initWithFormat:@" %d", [OrderData countByDishId:dishId]];
    [cell addSubview:count];
    
    cell.layer.borderWidth = 1.0f;
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // for simplicity we provide only 1 section
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
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Хавка! Пора жрать!";
}


@end
