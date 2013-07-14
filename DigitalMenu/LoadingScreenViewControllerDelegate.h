//
//  LoadingScreenViewControllerDelegate.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 14.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoadingScreenViewControllerDelegate <NSObject>
- (BOOL) isDataLoaded;
- (void) dismissLoadingScreen:(BOOL)animated;

@end
