//
//  DigitalMenuViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DigitalMenuViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *gTitle;
@property (copy, nonatomic) NSString *userName;
@property (weak, nonatomic) CLLocationManager *locationManager;

//- (IBAction)showRestaurants:(id)sender;
- (IBAction)showLocation:(id)sender;

@end
