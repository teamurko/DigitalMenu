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
    NSInteger categoryId;
    NSString *name;
}

@property NSInteger cagegoryId;
@property (strong, nonatomic) NSString *name;

- (id) initWithCategoryId: (NSInteger)categoryId andName:(NSString*)name;

@end
