//
//  RestaurantViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 17.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantViewController : UIViewController
{
    NSInteger restaurantId;
}

@property NSInteger restaurantId;

- (id) initWithRestaurandId:(NSInteger) restaurantId;

@end
