//
//  SplashScreenViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 10.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SplashScreenViewController.h"

#import "Debug.h"
#import "UtilHelper.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

@synthesize progressView = _progressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) updateProgress:(NSTimer*) timer
{
    const int NUM_PARTS = 4;
    static int index = 0;
    [self.progressView setProgress:(index / (double)NUM_PARTS) animated:NO];
    index = (index + 1) % (NUM_PARTS + 1);

}

- (void) viewDidAppear:(BOOL)animated
{
    debug();
    [super viewDidAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        while ([self.delegate isDataLoaded] == NO) {
            [NSThread sleepForTimeInterval:0.1];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self.delegate dismissSplashScreen:YES];
        });
    });
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    debug();
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) loadView
{
    [super loadView];

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.png"]];
    self.view = backgroundView;
    
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1];
    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.layer.borderColor = [UtilHelper mainGreenColor].CGColor;
    self.progressView.frame = CGRectMake(100, 161, 120, 49);
    UIImage *progressMask = [UIImage imageNamed:@"progress_mask.png"];
    UIImageView *progressMaskView = [[UIImageView alloc] initWithImage:progressMask];
    progressMaskView.frame = CGRectMake(100, 147, 120, 34);
    [self.progressView sizeToFit];
    self.progressView.trackTintColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1];
    [self.progressView setTransform:CGAffineTransformMakeScale(1.0, 2.0)];
    [self.progressView setProgress:0 animated:NO];
    self.progressView.progressTintColor = [UtilHelper mainGreenColor];
    [self.view addSubview:self.progressView];
    [self.view addSubview:progressMaskView];
    [self.view reloadInputViews];
}


@end
