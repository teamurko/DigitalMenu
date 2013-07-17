//
//  LoadingViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LoadingScreenViewController.h"
#import "PickRestaurantViewController.h"
#import "Debug.h"

@interface LoadingScreenViewController ()

@end

@implementation LoadingScreenViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) loadView
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 190, 300, 40)];
    textView.text = @"Определение вашего местоположения..";
    [textView setFont:[UIFont boldSystemFontOfSize:14]];
    [textView setTextColor:[UIColor whiteColor]];
    [textView setTextAlignment:NSTextAlignmentJustified];
    [textView setBackgroundColor:[UIColor blackColor]];
    textView.layer.borderWidth = 3.0f;
    [textView reloadInputViews];
    self.view = [[UIView alloc] init];
    [self.view addSubview:textView];
    [self.view clipsToBounds];
}

- (void) viewDidAppear:(BOOL)animated
{
    while ([self.delegate isDataLoaded] == NO) {
        [NSThread sleepForTimeInterval:0.1];
    }
    [self.delegate dismissLoadingScreen:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
}

- (void) viewWillDisappear:(BOOL)animated
{
}


@end
