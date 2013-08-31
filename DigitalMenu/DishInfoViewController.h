//
//  DishDescriptionViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishInfoViewController : UIViewController
{
    NSInteger dishId;
    NSString *name;
}

@property NSInteger dishId;
@property (strong, nonatomic) NSString *name;

-(id) initWithDishId:(NSInteger)dishId andName:(NSString*)name;

@end
