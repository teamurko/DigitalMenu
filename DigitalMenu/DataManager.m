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

const NSString *SERVER = @"http://ec2-54-229-72-121.eu-west-1.compute.amazonaws.com:8080";

@synthesize data = _data;

-(void) load {
    /*
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *dataPath = [bundle pathForResource:@"data.json" ofType:nil inDirectory:nil];
    
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSData *fileContents = [fileManager contentsAtPath:dataPath];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    self.data = [[[parser objectWithData:fileContents] objectForKey:@"houses"] copy];
     */
    NSString *string_url = [NSString stringWithFormat:@"%@/serverServices/restaurants/all", SERVER];
    NSURL *url = [[NSURL alloc] initWithString:string_url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rests = [[parser objectWithString:data] objectForKey:@"restaurant"];
    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
    NSLog(@"rests %@", rests);

    for (NSDictionary *rest in rests) {
        NSString *key = [rest objectForKey:@"id"];
        NSLog(@"key %@", key);
        [tempData setValue:rest forKey:key];
    }
    if (self.data == nil) {
        self.data = tempData;
    }

    NSLog(@"DATA2 %@", self.data);
}

-(NSArray*) houseIds {
    NSLog(@"House ids");
    NSString *url = @"http://ec2-54-229-72-121.eu-west-1.compute.amazonaws.com:8080/serverServices/restaurants/all";
    NSURL *URL = [[NSURL alloc] initWithString:url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:URL
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:30];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSLog(@"Response");
    NSLog(@"Error %@", error);
    NSLog(@"DATA %@", responseData);
    NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"string data %@", data);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rests = [[parser objectWithString:data] objectForKey:@"restaurant"];
    NSLog(@"rests %@", rests);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *d in rests) {
        [result addObject:[[d objectForKey:@"id"] copy]];
    }
    NSLog(@"result %@", result);
    NSLog(@"keys %@", self.data.allKeys);
    return result;
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
