//
//  DigitalMenuViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet MKMapView *mapView;
    IBOutlet UITextField *nameField;
    IBOutlet UILabel *gTitle;
    NSString *userName;
    IBOutlet UIPickerView *restaurantsFrontList;
    NSArray *restaurantButtons;
    DataManager *dataManager;
    UIView *view;
}
@property (strong, nonatomic) UIView *view;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *gTitle;
@property (copy, nonatomic) NSString *userName;
@property (weak, nonatomic) IBOutlet UIPickerView *restaurantsFrontList;
@property (copy, nonatomic) NSArray *restaurantButtons;
@property (weak, nonatomic) DataManager *dataManager;
- (IBAction)showLocation:(id)sender;
- (IBAction)showNearestHouse:(id)sender;

@end
