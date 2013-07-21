//
//  OrderData.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 21.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "Debug.h"
#import "OrderData.h"

@implementation OrderData

static NSMutableDictionary* volatile dishesCount_ = nil;

+ (void) init
{
    if (!dishesCount_) {
        dishesCount_ = [[NSMutableDictionary alloc] init];
    }
}

+ (void) addDish:(NSInteger) dishId
{
    [OrderData init];
    NSInteger count = 0;
    NSNumber *value = [dishesCount_ objectForKey:[NSNumber numberWithInteger:dishId]];
    if (value) {
        count = [value integerValue];
    }
    count += 1;
    [dishesCount_ setObject:[NSNumber numberWithInteger:count] forKey:[NSNumber numberWithInteger:dishId]];
}

+ (NSArray*) dishIds
{
    [OrderData init];
    NSLog(@"All keys: %@", [dishesCount_ allKeys]);
    return [dishesCount_ allKeys];
}

+ (void) clear
{
    [dishesCount_ removeAllObjects];
}

@end
