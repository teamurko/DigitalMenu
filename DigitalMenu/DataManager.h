//
//  DataManager.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject {
    NSMutableDictionary* data;
}

@property (weak, nonatomic) NSMutableDictionary* data;

-(void) load;
-(NSArray*) restaurants;
-(NSArray*) cuisines:(NSString*)restaurantId;
-(NSArray*) dishes:(NSString*)restaurantId secondValue:(NSString*)cuisineId;

@end
