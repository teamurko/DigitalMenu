//
//  DigitalMenuViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DataManager.h"
#import "SplashScreenViewController.h"
#import "SplashScreenViewControllerDelegate.h"
#import "LoadingScreenViewControllerDelegate.h"

@interface PickRestaurantViewController : UIViewController <SplashScreenViewControllerDelegate, LoadingScreenViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate> {
    DataManager *dataManager;
    IBOutlet UITableView *restaurantsView;
}
@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) UITableView *restaurantsView;

@end
