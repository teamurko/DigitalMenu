//
//  DishesViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 26.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>

@interface DishesViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSString *houseId;
    NSString *cuisineId;
    NSString *dishesCategory;
    DataManager *dataManager;
}

@property (weak, nonatomic) NSString *houseId;
@property (weak, nonatomic) NSString *cuisineId;
@property (weak, nonatomic) NSString *dishesCategory;
@property (strong, nonatomic) DataManager *dataManager;

- (id) initWithData:(DataManager*)dataManager andHouseId:(NSString*)houseId andCuisineId:(NSString*)cuisineId andDishesCategory:(NSString*)dishesCategory;

@end
