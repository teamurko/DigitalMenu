//
//  OrderData.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 21.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderData : NSObject
{
}

+ (void) addDish:(NSInteger) dishId;
+ (NSArray*) dishIds;
+ (void) clear;
+ (NSInteger) countByDishId:(NSInteger)dishId;

@end
