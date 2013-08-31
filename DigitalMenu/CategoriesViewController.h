//
//  CategoriesViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 01.09.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger cuisineId;
    NSString *name;
}

@property NSInteger cuisineId;
@property (strong, nonatomic) NSString *name;

- (id) initWithCuisineId:(NSInteger)cuisineId andName:(NSString*)name;

@end
