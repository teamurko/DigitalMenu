//
//  CuisinesViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 25.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>

@interface CuisinesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *view;
    DataManager *dataManager;
    NSString *houseId;
}

@property (weak, nonatomic) UITableView *view;
@property (strong, nonatomic) DataManager *dataManager;
@property (copy, nonatomic) NSString *houseId;
-(id) initWithHouseId:(NSString*)theHouseId;

@end
