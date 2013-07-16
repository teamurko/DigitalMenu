//
//  DataManager.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject {
    NSMutableDictionary* dataDict;
}

@property (strong, nonatomic) NSMutableDictionary* dataDict;

-(void) load;
-(NSArray*) restaurantsByLocation: (double)longitude andLatitude:(double)latitude;


-(NSArray*) houseIds;
-(NSDictionary*) houseInfo:(NSString*)houseId;
-(NSArray*) cuisines:(NSString*)houseId;
-(NSArray*) dishesCategories:(NSString*)houseId secondValue:(NSString*)cuisineId;
-(NSDictionary*) dishes:(NSString*)houseId andCuisineId:(NSString*)cuisineId andDishesCategory:(NSString*)dishesCategories;

@end
