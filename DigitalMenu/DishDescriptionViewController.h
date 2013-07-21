//
//  DishDescriptionViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishDescriptionViewController : UIViewController
{
    NSInteger dishId;
}

@property NSInteger dishId;

-(id) initWithDishId:(NSInteger)dishId;

@end
