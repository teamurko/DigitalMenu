//
//  DataManager.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import "json/SBJsonParser.h"

@implementation DataManager

@synthesize data = _data;

-(void) load {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"data.json" ofType:nil inDirectory:nil];
    
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSData *fileContents = [fileManager contentsAtPath:dataPath];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    self.data = [[[parser objectWithData:fileContents] objectForKey:@"houses"] copy];
}

-(NSArray*) houseIds {
    return self.data.allKeys;
}

-(NSDictionary*) houseInfo:(NSString*) houseId {
    return [self.data objectForKey:houseId];
}


-(NSArray*) cuisines:(NSString*)houseId {
    return [[[self.data objectForKey:houseId] objectForKey:@"cuisines"] allKeys];
}

-(NSArray*) dishesCategories:(NSString *)houseId secondValue:(NSString *)cuisineId {
    return [[[[self.data objectForKey:houseId] objectForKey:@"cuisines"] objectForKey:cuisineId] allKeys];
}

-(NSDictionary*) dishes:(NSString*)houseId andCuisineId:(NSString*)cuisineId andDishesCategory:(NSString*)dishesCategory
{
    NSDictionary *dishesCategories = [[[self.data objectForKey:houseId] objectForKey:@"cuisines"] objectForKey:cuisineId];
    return [dishesCategories objectForKey:dishesCategory];
}



@end
