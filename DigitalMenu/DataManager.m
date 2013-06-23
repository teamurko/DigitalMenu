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
    NSLog(@"houses: %@", self.data);
}

-(NSArray*) houseIds {
    NSLog(@"DATA: %@", self.data);
    return self.data.allKeys;
}

-(NSDictionary*) houseInfo:(NSString*) houseId {
    return [self.data objectForKey:houseId];
}


-(NSArray*) cuisines:(NSString*)restaurantId {
    return [self.data objectForKey:restaurantId];
}

-(NSArray*) dishes:(NSString*)restaurantId secondValue:(NSString*)cuisineId {
    return nil;
}


@end
