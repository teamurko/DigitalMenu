//
//  RestaurantViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 17.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "UtilHelper.h"
#import "DataManager.h"
#import "DishViewController.h"
#import "RestaurantViewController.h"
#import "PickRestaurantViewController.h"
#import "OrderViewController.h"
#import "CategoriesViewController.h"

#define kSegmentedControlHeight 40.0
#define kLabelHeight			20.0

#define kLeftMargin				20.0
#define kTopMargin				10.0
#define kRightMargin			20.0
#define kTweenMargin			6.0

#define kTextFieldHeight		30.0


@interface RestaurantViewController ()

@end

@implementation RestaurantViewController
@synthesize restaurantId = _restaurantId;

NSInteger chosenCuisineId;
NSMutableArray *ids;

- (id) initWithRestaurandId:(NSInteger)restaurantId
{
    debug();
    self = [super init];
    if (self) {
        self.restaurantId = restaurantId;
    }
    return self;
}

- (void)changeCuisine:(id)sender
{
    debug();
    NSLog(@"%@", sender);
    UISegmentedControl *segmentControl = (UISegmentedControl*)sender;
    NSLog(@"Segment index %d", segmentControl.selectedSegmentIndex);
    chosenCuisineId = [[ids objectAtIndex:segmentControl.selectedSegmentIndex] integerValue];
    //FIXME do not fucking write shit code
    UITableView *tableView = [self.view.subviews objectAtIndex:[self.view subviews].count - 2];
    [tableView reloadData];
}

- (void) showOrder:(id)sender
{
    debug();
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:orderViewController animated:YES];
}

- (void) addRouteButton
{
    UIImageView *routeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rest_route.png"]];
    routeImageView.frame = CGRectOffset(routeImageView.frame, 0, 1);
    //    routeImageView.layer.borderWidth = 1;
    UILabel *routeLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, 55, 15)];
    routeLabel.text = @"Show route";
    [routeLabel setFont:[UIFont systemFontOfSize:10]];
    routeLabel.backgroundColor = [UIColor clearColor];
    routeLabel.textColor = [UIColor whiteColor];
    //    routeLabel.layer.borderWidth = 1;
    
    UIView *routeView = [[UIView alloc] initWithFrame:CGRectMake(8, 5, 80, 15)];
    //    routeView.layer.borderWidth = 1;
    [routeView addSubview:routeImageView];
    [routeView addSubview:routeLabel];
    

    UIButton *routeButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 97, 120, 25)];
    [routeButton setBackgroundImage:[UtilHelper imageFromColor:[UtilHelper orangeNormal] andSize:routeButton.frame.size] forState:UIControlStateNormal];
    [routeButton setBackgroundImage:[UtilHelper imageFromColor:[UtilHelper orangeSelected] andSize:routeButton.frame.size] forState:UIControlStateSelected];
    routeButton.tintColor = [UIColor whiteColor];
    [routeButton addSubview:routeView];
    [routeButton addTarget:self action:@selector(showRoute) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:routeButton];
    
}

- (void) addCallButton
{
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rest_phone.png"]];
    phoneImageView.frame = CGRectOffset(phoneImageView.frame, 0, 1);
    //    routeImageView.layer.borderWidth = 1;
    UILabel *callLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, 55, 15)];
    callLabel.text = @"Call";
    [callLabel setFont:[UIFont systemFontOfSize:10]];
    callLabel.backgroundColor = [UIColor clearColor];
    callLabel.textColor = [UIColor whiteColor];
    //    routeLabel.layer.borderWidth = 1;
    
    UIView *callView = [[UIView alloc] initWithFrame:CGRectMake(8, 5, 80, 15)];
    //    routeView.layer.borderWidth = 1;
    [callView addSubview:phoneImageView];
    [callView addSubview:callLabel];
    
    UIButton *callButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 132, 120, 25)];
    [callButton setBackgroundImage:[UtilHelper imageFromColor:[UtilHelper orangeNormal] andSize:callButton.frame.size] forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UtilHelper imageFromColor:[UtilHelper orangeSelected] andSize:callButton.frame.size] forState:UIControlStateSelected];
    callButton.tintColor = [UIColor whiteColor];
    [callButton addSubview:callView];
    [callButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:callButton];
}

- (void) addAddress:(NSDictionary*) restaurant
{
    UIImageView *balloonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rest_location.png"]];
    UITextView *addressText = [[UITextView alloc] initWithFrame:CGRectMake(15, -5, 105, 40)];
    addressText.editable = NO;
    //    addressText.layer.borderWidth = 1;
    addressText.text = [restaurant objectForKey:@"address"];
    [addressText setFont:[UIFont systemFontOfSize:8]];
    UITextView *addressView = [[UITextView alloc] initWithFrame:CGRectMake(163, 50, 130, 40)];
    addressView.editable = NO;
    [addressView addSubview:balloonView];
    [addressView addSubview:addressText];
    //    addressView.layer.borderWidth = 1;
    [self.view addSubview:addressView];
}

- (void) addWorkTime:(NSDictionary*) restaurant
{
    UITextView *timeView = [[UITextView alloc] initWithFrame:CGRectMake(160, 20, 90, 20)];
    timeView.editable = NO;
    UIImageView *clockView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rest_clock.png"]];
    //    [clockView setTransform:CGAffineTransformMakeScale(0.7, 0.7)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 60, 15)];
    timeLabel.text = [UtilHelper renderedWorkHours:[[restaurant objectForKey:@"open_from"] integerValue]  andTill:[[restaurant objectForKey:@"open_till"] integerValue]];
    [timeLabel setFont:[UIFont systemFontOfSize:10]];
    //    timeLabel.adjustsFontSizeToFitWidth = YES;
    [timeView addSubview:clockView];
    [timeView addSubview:timeLabel];
    timeView.layer.borderWidth = 0;
    [self.view addSubview:timeView];
}

- (void) addDescription:(NSDictionary*) restaurant
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 180, 320, 140)];
    textView.text = [restaurant objectForKey:@"description"];
//    textView.layer.borderWidth = 1;
    [self.view addSubview:textView];
}

- (void) addLogo:(NSDictionary*) restaurant
{
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stub_logo.png"]];
    logoView.frame = CGRectOffset(logoView.frame, 10, 20);
    [self.view addSubview:logoView];    
}

- (void) addPictures:(NSDictionary*) restaurant
{
    static float distanceBetweenPictures = 15;
    UIScrollView *pictures = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 320, 320, 140)];
    [pictures setPagingEnabled:YES];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rest_photo1.png"]];
    imageView1.frame = CGRectOffset(imageView1.frame, distanceBetweenPictures / 2, 5);
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rest_photo2.png"]];
    imageView2.frame = CGRectOffset(imageView2.frame, imageView1.frame.origin.x + imageView1.frame.size.width + distanceBetweenPictures, 5);
    
    [pictures addSubview:imageView1];
    [pictures addSubview:imageView2];
    pictures.contentSize = CGSizeMake(imageView1.frame.size.width + distanceBetweenPictures + imageView2.frame.size.width, imageView1.frame.size.height);
    
    pictures.backgroundColor = [UIColor colorWithRed:245.0/255 green:241.0/255 blue:230.0/255 alpha:1.0];
    [self.view addSubview:pictures];
}

- (void) loadView
{
    debug();
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *restaurant = [DataManager restaurantById:self.restaurantId];
    
    [self addLogo:restaurant];
    [self addDescription:restaurant];
    [self addWorkTime:restaurant];
    [self addAddress:restaurant];
    [self addRouteButton];
    [self addCallButton];
    [self addPictures:restaurant];
    [self configureNavigationBar];
}

- (void) backToAll
{
    [self.navigationController popViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"makeVisible" object:nil];
}


- (void) showMenu
{
    debug();
    CategoriesViewController *categoriesViewController = [[CategoriesViewController alloc] initWithRestaurandId:self.restaurantId];
    categoriesViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:categoriesViewController animated:YES];
}

- (void) showMap
{
    debug();
    [self backToAll];
}

- (void) showOrder
{
    debug();
}

- (void) showRoute

{
    debug();
    [self backToAll];
}

- (void) call
{
    debug();
}

- (void) configureNavigationBar
{
    UIView *backButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"back2.png"] andActImage:[UIImage imageNamed:@"back_act.png"] andAction:@selector(backToAll) offsetTop:9 offsetBottom:0 offsetRight:0 offsetLeft:9];
    backButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    
    UIView *menuButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"menu.png"] andActImage:[UIImage imageNamed:@"menu_act.png"] andAction:@selector(showMenu) offsetTop:9 offsetBottom:0 offsetRight:9 offsetLeft:0];
    menuButtonView.frame = CGRectMake(10, 10, 40, 40);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:menuButtonView];
    
    self.navigationItem.rightBarButtonItem = menuButton;
    self.navigationItem.leftBarButtonItem = backButton;
    NSDictionary *data = [DataManager restaurantById:self.restaurantId];
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 40, 40);
    //    self.navigationItem.titleView.layer.borderWidth = 1.0f;
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"name"]];
    
    UIView *mapButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"mapButton.png"] andActImage:[UIImage imageNamed:@"mapButtonAct.png"] andAction:@selector(showMap) offsetTop:15 offsetBottom:12 offsetRight:35 offsetLeft:32];
    mapButtonView.layer.borderWidth = 1;
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithCustomView:mapButtonView];
    
    UIView *restButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"restButton.png"] andActImage:[UIImage imageNamed:@"restButtonAct.png"] andAction:nil offsetTop:15 offsetBottom:12 offsetRight:35 offsetLeft:35];
    restButtonView.layer.borderWidth = 1;
    UIBarButtonItem *restButton = [[UIBarButtonItem alloc] initWithCustomView:restButtonView];
    
    UIView *orderButtonView = [UtilHelper buttonView:self andImage:[UIImage imageNamed:@"orderButton.png"] andActImage:[UIImage imageNamed:@"orderButtonAct.png"] andAction:@selector(showOrder) offsetTop:15 offsetBottom:12 offsetRight:35 offsetLeft:35];
    orderButtonView.layer.borderWidth = 1;
    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithCustomView:orderButtonView];
    
    [self setToolbarItems:[NSArray arrayWithObjects:mapButton, restButton, orderButton, nil]];    
}

- (void)viewDidLoad
{
    debug();
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    debug();
    return [DataManager dishCategoriesByCuisineId:chosenCuisineId].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    debug();
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[[DataManager dishCategoriesByCuisineId:chosenCuisineId] objectAtIndex:indexPath.row] objectForKey:@"name"];
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
    NSDictionary *data = [[DataManager dishCategoriesByCuisineId:chosenCuisineId] objectAtIndex:indexPath.row];
    NSInteger categoryId = [[data objectForKey:@"id"] integerValue];
    NSString *name = [data objectForKey:@"name"];
    DishViewController *dishViewController = [[DishViewController alloc] initWithDishCategory:categoryId andName:name];
    [self.navigationController pushViewController:dishViewController animated:YES];
//    NSArray *candidates = [DataManager restaurantsByLocation:userLocation];
//    NSString *id = [[candidates objectAtIndex:[indexPath row]] objectForKey:@"id"];
//    [self showRestaurantView:id.intValue andAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Приятного аппетита!";
}


@end
