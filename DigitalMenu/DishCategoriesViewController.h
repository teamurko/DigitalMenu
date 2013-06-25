//
//  DishCategoriesViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 25.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>

@interface DishCategoriesViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSString *houseId;
    NSString *cuisineId;
    DataManager *dataManager;
}

@property (weak, nonatomic) NSString *houseId;
@property (weak, nonatomic) NSString *cuisineId;
//TODO read more about reference types
@property (strong, nonatomic) DataManager *dataManager;

- (id) initWithData:(DataManager*)dataManager andHouseId:(NSString*)houseId andCuisineId:(NSString*)cuisineId;

@end
