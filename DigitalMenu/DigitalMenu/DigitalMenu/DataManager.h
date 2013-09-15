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

+(void) load:(CLLocation*)userLocation;
+(NSArray*) restaurantsByLocation: (CLLocation*) location;
+(NSDictionary*) restaurantById: (NSInteger) restaurantId;
+(NSArray*) cuisinesByRestaurantId: (NSInteger) restaurantId;
+(CLLocation*) restaurantLocation: (NSInteger) restaurantId;
+(NSArray*) dishCategoriesByCuisineId: (NSInteger) cuisineId;
+(NSArray*) dishesByCategoryId: (NSInteger) categoryId;
+(NSDictionary*) dishById: (NSInteger) dishId;
+(NSArray*) nearbyRestaurants;

@end
