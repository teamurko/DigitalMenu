//
//  LoadingViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import "LoadingScreenViewControllerDelegate.h"

@interface LoadingScreenViewController : UIViewController <CLLocationManagerDelegate>
{
    UITextView *view;
}

@property (strong, nonatomic) UITextView *view;
@property (assign, nonatomic) id<LoadingScreenViewControllerDelegate> delegate;

- (CLLocation*) getCurrentLocation;

@end
