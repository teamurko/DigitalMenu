//
//  SplashScreenViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "LoadingViewController.h"

#import "SplashScreenViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSThread sleepForTimeInterval:1];
    LoadingViewController *loadingController = [[LoadingViewController alloc] init];
    [loadingController.navigationItem setHidesBackButton:YES];
    [self.navigationController pushViewController:loadingController animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadView
{
    NSLog(@"LOAD SPLASH SCREEN VIEW");
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spring.jpg"]];
    self.view = imageView;
    [imageView reloadInputViews];
}


@end
