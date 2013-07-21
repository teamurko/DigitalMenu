//
//  DishDescriptionViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "Debug.h"
#import "DataManager.h"
#import "DishDescriptionViewController.h"

@interface DishDescriptionViewController ()

@end

@implementation DishDescriptionViewController
@synthesize  dishId = _dishId;

- (id)initWithDishId:(NSInteger)dishId
{
    self = [super init];
    if (self) {
        self.dishId = dishId;
    }
    return self;
}

- (void)loadView
{
    debug();
    NSDictionary *dishData = [DataManager dishById:self.dishId];
    UIView *mainView = [[UIView alloc] init];
    self.view = mainView;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [dishData objectForKey:@"name"];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor],
                          UITextAttributeTextShadowColor: [UIColor blackColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"Helvetica" size:14.0f]
     };
    [self.navigationController.navigationItem.titleView sizeToFit];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    descriptionLabel.text = @"Описание";
    [self.view addSubview:descriptionLabel];
    
    UITextView *description = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 280, 100)];
    description.text = [[DataManager dishById:self.dishId] objectForKey:@"summary"];
    [description setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    description.layer.borderWidth = 2.0f;
    [self.view addSubview:description];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 60, 30)];
    priceLabel.text = @"Цена:";
    [self.view addSubview:priceLabel];
    
    UITextView *price = [[UITextView alloc] initWithFrame:CGRectMake(90, 160, 100, 30)];
    price.text = [[NSString alloc] initWithFormat:@"%@", [dishData objectForKey:@"price"]];
    price.font = [UIFont fontWithName:@"Courier" size:18.0];
    price.userInteractionEnabled = NO;
    [self.view addSubview:price];
    
//    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithTitle:@"Заказ" style:UIBarButtonItemStyleDone target:self action:@selector(showOrder:)];

    
    [self.view clipsToBounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
