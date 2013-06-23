//
//  FoodPlacesViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 23.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>

@interface FoodPlacesViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *view;
    DataManager *dataManager;
}
@property (weak, nonatomic) UITableView *view;
@property (strong, nonatomic) DataManager *dataManager;

@end
