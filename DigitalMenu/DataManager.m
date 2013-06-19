//
//  DataManager.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

@synthesize data = _data;

-(void) load {
    for (NSString *name in [[NSArray alloc] initWithObjects:@"Shushi-Mushi", @"Cantina", @"Segafredo", nil]) {
        NSMutableArray *cuisines = [[NSMutableArray alloc] init];
        for (NSString *cuisine in [[NSArray alloc]
                                   initWithObjects:@"Ukranian", @"Chineese", @"Spanish", @"French", nil]) {
            [cuisines addObject:cuisine];
        }
        [self.data setValue:cuisines forKey:name];
    }
}

-(NSArray*) restaurants {
    return self.data.allKeys;
}

-(NSArray*) cuisines:(NSString*)restaurantId {
    return [self.data objectForKey:restaurantId];
}

-(NSArray*) dishes:(NSString*)restaurantId secondValue:(NSString*)cuisineId {
    return nil;
}


@end
