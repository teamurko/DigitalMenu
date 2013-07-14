//
//  SplashScreenViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SplashScreenViewControllerDelegate.h"

@interface SplashScreenViewController: UIViewController 
{
    UIImageView *view;
}

@property (strong, nonatomic) UIImageView *view;
@property (assign, nonatomic) id<SplashScreenViewControllerDelegate> delegate;

@end
