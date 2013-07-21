//
//  DishViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger dishCategory;
    NSString *name;
}

@property NSInteger dishCategory;
@property (strong, nonatomic) NSString *name;

- (id) initWithDishCategory: (NSInteger) dishCategory andName: (NSString*) name;

@end
