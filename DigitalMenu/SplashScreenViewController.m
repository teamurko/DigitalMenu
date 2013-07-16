//
//  SplashScreenViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "LoadingScreenViewController.h"
#import "SplashScreenViewController.h"

#import "Debug.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSThread sleepForTimeInterval:0.2];
    [self.delegate dismissSplashScreen:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.delegate showLoading:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) loadView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spring.jpg"]];
    self.view = imageView;
    [imageView reloadInputViews];
}


@end
