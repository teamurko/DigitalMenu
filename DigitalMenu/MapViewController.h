//
//  MapViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 19.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
{
    NSInteger restaurantId;
}

@property NSInteger restaurantId;

- (id) initWithRestaurandId:(NSInteger)restaurantId;

@end
