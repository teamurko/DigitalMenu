//
//  LoadingViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoadingScreenViewControllerDelegate.h"

@interface LoadingScreenViewController : UIViewController
{
    UIView *view;
}

@property (strong, nonatomic) UIView *view;
@property (assign, nonatomic) id<LoadingScreenViewControllerDelegate> delegate;

@end
