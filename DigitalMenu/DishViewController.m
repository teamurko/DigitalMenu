//
//  DishViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "DishViewController.h"
#import "DataManager.h"
#import "DishDescriptionViewController.h"

@interface DishViewController ()

@end

@implementation DishViewController
@synthesize dishCategory = _dishCategory;
@synthesize name = _name;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDishCategory:(NSInteger)dishCategory andName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.dishCategory = dishCategory;
        self.name = name;
    }
    return self;
}

- (void) loadView
{
    debug();
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    self.view.backgroundColor = [UIColor whiteColor];
        
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 250)];
    tableView.layer.borderWidth = 3.0f;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    [self.view clipsToBounds];
}

- (void) showOrder:(id)sender
{
    debug();
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithTitle:@"Заказ" style:UIBarButtonItemStyleDone target:self action:@selector(showOrder:)];
    
    self.navigationItem.rightBarButtonItem = orderButton;
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"%@", self.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    return [DataManager dishesByCategoryId:self.dishCategory].count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO rewrite not to rely on fixed order of elements
    debug();
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[[DataManager dishesByCategoryId:self.dishCategory] objectAtIndex:indexPath.row] objectForKey:@"name"];
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
    //FIXME do not rely on dishes order
    NSDictionary *dishData = [[DataManager dishesByCategoryId:self.dishCategory] objectAtIndex:indexPath.row];
    DishDescriptionViewController *dishDescriptionViewController = [[DishDescriptionViewController alloc] initWithDishId:[[dishData objectForKey:@"id"] integerValue]];
    [self.navigationController pushViewController:dishDescriptionViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Приятного аппетита!";
}

@end
