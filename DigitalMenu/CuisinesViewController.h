//
//  CategoriesViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 27.08.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuisinesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger restaurantId;
}

@property NSInteger restaurantId;

- (id) initWithRestaurandId:(NSInteger) restaurantId;

@end
