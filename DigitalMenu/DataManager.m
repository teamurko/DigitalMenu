//
//  DataManager.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import "Json/SBJsonParser.h"
#import "Debug.h"

@implementation DataManager

const NSString *SERVER = @"http://ec2-54-229-72-121.eu-west-1.compute.amazonaws.com:8080";
const NSString *URL = @"/serverServices/";

@synthesize dataDict = _dataDict;

-(void) load
{
    debug();
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
    if (self.dataDict == nil) {
        self.dataDict = tempData;
    }

    NSLog(@"DATA2 %@", self.dataDict);
}

-(NSArray*) restaurantsByLocation:(double)longitude andLatitude:(double)latitude
{
    NSString *string_url = [NSString stringWithFormat:@"%@%@/find?longitude=%f&latitude=%f",
                            SERVER, URL, longitude, latitude];
    NSURL *url = [[NSURL alloc] initWithString:string_url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:5];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *result = [[parser objectWithString:data] objectForKey:@"restaurant"];
    NSLog(@"%@", result);
    return result;
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
    NSLog(@"keys %@", self.dataDict.allKeys);
    return result;
}

-(NSDictionary*) houseInfo:(NSString*) houseId {
    return [self.dataDict objectForKey:houseId];
}


-(NSArray*) cuisines:(NSString*)houseId {
    return [[[self.dataDict objectForKey:houseId] objectForKey:@"cuisines"] allKeys];
}

-(NSArray*) dishesCategories:(NSString *)houseId secondValue:(NSString *)cuisineId {
    return [[[[self.dataDict objectForKey:houseId] objectForKey:@"cuisines"] objectForKey:cuisineId] allKeys];
}

-(NSDictionary*) dishes:(NSString*)houseId andCuisineId:(NSString*)cuisineId andDishesCategory:(NSString*)dishesCategory
{
    NSDictionary *dishesCategories = [[[self.dataDict objectForKey:houseId] objectForKey:@"cuisines"] objectForKey:cuisineId];
    return [dishesCategories objectForKey:dishesCategory];
}



@end
