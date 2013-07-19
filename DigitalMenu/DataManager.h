//
//  DataManager.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DataManager : NSObject {
}

+(void) load;
+(NSArray*) restaurantsByLocation: (CLLocation*) location;
+(NSDictionary*) restaurantById: (NSInteger) restaurantId;
+(NSArray*) cuisinesByRestaurantId: (NSInteger) restaurantId;
+(NSArray*) restaurants;
+(CLLocation*) restaurantLocation: (NSInteger) restaurantId;

@end
