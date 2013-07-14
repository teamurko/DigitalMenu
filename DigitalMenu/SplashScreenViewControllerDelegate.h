//
//  SplashScreenViewControllerDelegate.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 14.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SplashScreenViewControllerDelegate <NSObject>
- (void) dismissSplashScreen:(BOOL)animated;
- (void) showLoading:(BOOL)animated;
@end
